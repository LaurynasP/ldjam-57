extends Control
class_name RecipeUI

const ITEM_UI = preload("res://features/gameplay_ui/recipe_ui/item_ui.tscn")

@onready var product_container := %ProductContainer
@onready var ingredients_container := %IngredientsContainer
@onready var product := %Product
var recipe: Recipe

func _ready() -> void:
	product.texture = recipe.product.icon
	
	for ingredient in recipe.ingredients:
		var ingredient_ui = ITEM_UI.instantiate() as TextureRect
		ingredient_ui.texture = ingredient.icon
		ingredients_container.add_child(ingredient_ui)
	pass

func init(recipe: Recipe):
	self.recipe = recipe

	
