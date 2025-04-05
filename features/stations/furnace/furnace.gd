extends Station
class_name Furnace

@export var is_in_use: bool
@export var progress: int
@export var recipes: Array[Recipe]

var loaded_recipes: Dictionary[String, Recipe]
var available_recipes: Dictionary[String, Recipe]

var added_resources: Array[Item] = []

signal on_resource_added(resource: String)

func _ready() -> void:
	loaded_recipes = RecipeManager.get_recipes(recipes)
	available_recipes = loaded_recipes

func add_item(item: String) -> bool:
	if (RecipeManager.is_resource_in_recipes(item, available_recipes.values())):
		available_recipes = RecipeManager.get_related_recipes(item, available_recipes.values())
		on_resource_added.emit(item)
		return true
	
	return false
	
func do_processing():
	pass
