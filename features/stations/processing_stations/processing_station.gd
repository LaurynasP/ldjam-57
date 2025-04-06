extends Station
class_name ProcessingStation

@export var recipes: Array[Recipe]

var loaded_recipes: Dictionary[String, Recipe]

var available_recipes: Dictionary[String, Recipe]

var prepared_item: Item
var progress: int

signal on_progress_tick(progress: int)
signal on_processing_completed(product: Item)
signal on_product_removed(product: Item)

func _ready() -> void:
	loaded_recipes = RecipeManager.get_recipes(recipes)
	reset_station()
	super()
	
func _process(delta: float) -> void:
	var items = inventory.duplicate()
	
	if prepared_item != null:
		items.append(prepared_item)
		
	ui.station_ui.update_ui(items)
	
	if progress > 0:
		ui.station_ui.timer_bar.visible = true
		ui.station_ui.timer_bar.max_value = 100
		ui.station_ui.timer_bar.value = progress
		ui.station_ui.timer_bar.time_left = progress
	else:
		ui.station_ui.timer_bar.visible = false
	
func add_item(item: Item) -> bool:
	if prepared_item != null:
		return false
		
	if ItemManager.is_item_already_in_inventory(item, inventory):
		return false
	
	if not RecipeManager.is_resource_in_recipes(item, available_recipes.values()):
		return false
	
	available_recipes = RecipeManager.get_related_recipes(item, available_recipes.values())
	inventory.append(item)
	progress = max(0, progress - 40)
	on_resource_added.emit(item)
	play_add_remove_sound_effect()
	return true

func remove_item() -> Item:
	if prepared_item != null:
		play_add_remove_sound_effect()
		return retrieve_product()
	if progress == 0:
		var result = inventory.pop_back()
		available_recipes = RecipeManager.get_inventory_related_recipes(inventory, loaded_recipes.values())
		if result != null:
			play_add_remove_sound_effect()
		return result
	
	return null

func do_processing(increment: int = 5):
	if inventory.size() == 0:
		return
		
	if prepared_item != null:
		return
	
	progress += increment
	
	progress = min(100, progress)
	
	if progress == 100: 
		complete_product()
		return
	
	on_progress_tick.emit(progress)
	pass
	
func complete_product():
	var recipe = RecipeManager.get_completable_recipe(available_recipes.values(), inventory)
	
	if recipe == null:
		return
	
	prepared_item = recipe.product
	
	reset_station()
	play_crafted_sound_effect()
	on_processing_completed.emit(prepared_item)
	
func retrieve_product() -> Item:
	var product = prepared_item
	prepared_item = null
	
	on_product_removed.emit(product)
	return product
	
func reset_station():
	available_recipes = loaded_recipes.duplicate()
	inventory = []
	progress = 0
