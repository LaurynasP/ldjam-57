extends Node

var recipes: Dictionary[String, Recipe]

func _ready() -> void:
	var r = (load("res://configurations/recipe_database.tres") as Recipes).recipes
	
	for recipe in r:
		recipes[recipe.name] = recipe
