extends Node

var recipes: Dictionary[String, Recipe]

func _ready() -> void:
	var r = (load("res://configurations/recipe_database.tres") as Recipes).recipes
	
	for recipe in r:
		recipes[recipe.name] = recipe

func get_recipes(searchables: Array[Recipe]) -> Dictionary[String, Recipe]:
	var result: Dictionary[String, Recipe] = {}
	for item in searchables:
		result[item.name] = recipes[item.name]
		
	return result
	
func is_resource_in_recipes(resource: Item, available_recipes: Array[Recipe]) -> bool:
	for recipe in available_recipes:
		if is_resource_in_recipe(resource, recipe):
			return true
		
	return false
	
func is_resource_in_recipe(resource: Item, recipe: Recipe) -> bool:
	return recipe.ingredients.any(func(i: Item): return i.name == resource.name)

func get_related_recipes(resource: Item, available_recipes: Array[Recipe]) -> Dictionary[String, Recipe]:
	var result: Dictionary[String, Recipe] = {}
	for recipe in available_recipes:
		if is_resource_in_recipe(resource, recipe):
			result[recipe.name] = recipe
		
	return result

func can_complete_recipe(recipe: Recipe, items: Array[Item]) -> bool:
	var result = true
	for ingredient in recipe.ingredients:
		if not items.any(func(i: Item): return i.name == ingredient.name):
			result = false
			
	return result
