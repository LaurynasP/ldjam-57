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
	on_ready()
	
func on_ready():
	pass

func add_item(item: Item) -> bool:
	if prepared_item != null:
		return false
		
	if ItemManager.is_item_already_in_inventory(item, inventory):
		return false
	
	if not RecipeManager.is_resource_in_recipes(item, available_recipes.values()):
		return false
	
	available_recipes = RecipeManager.get_related_recipes(item, available_recipes.values())
	inventory.append(item)
	on_resource_added.emit(item)
	
	return true

func remove_item() -> Item:
	if prepared_item != null:
		return retrieve_product()
	if progress == 0:
		return inventory.pop_back()
	
	return null

func interact():
	print("Interacted with furance")
	pass

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
	if available_recipes.size() != 1:
		return
		
	var recipe = available_recipes.values()[0]
	
	var can_cook = true
	for ingredient in recipe.ingredients:
		if not inventory.any(func(item: Item): return item.name == ingredient.name):
			can_cook = false
	
	if not can_cook:
		return
	
	prepared_item = available_recipes.values()[0].product
	
	reset_station()
	
	on_processing_completed.emit(prepared_item)
	
func retrieve_product() -> Item:
	var product = prepared_item
	prepared_item = null
	
	on_product_removed.emit(product)
	return product
	
func reset_station():
	available_recipes = loaded_recipes
	inventory = []
	progress = 0
