extends Node

var recipes: Array[Recipe]

func _ready() -> void:
	recipes = (load("res://configurations/recipe_database.tres") as Recipes).recipes
	
	for n in range(recipes.size()):
		recipes[n].id = n
		
