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
	
func interact():
	pass

func do_processing():
	if inventory.size() == 0:
		return
		
	if prepared_item != null:
		return
		
	if progress == 100: 
		complete_product()
		return
	
	progress += 1
	
	on_progress_tick.emit(progress)
	pass
	
func complete_product():
	if available_recipes.size() != 1:
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
