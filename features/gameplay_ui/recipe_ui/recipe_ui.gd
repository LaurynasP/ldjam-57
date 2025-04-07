extends Control
class_name RecipeUI

const ITEM_UI = preload("res://features/gameplay_ui/recipe_ui/item_ui.tscn")
const PLACEHOLDER_ICON = preload("res://assets/images/icons/placeholder.png")

@onready var product_container := %ProductContainer
@onready var ingredients_container := %IngredientsContainer
@onready var product := %Product

var recipe: Recipe
var is_placeholder: bool

func _ready() -> void:
	product.texture = PLACEHOLDER_ICON if is_placeholder else recipe.product.icon
	
	for ingredient in recipe.ingredients:
		var ingredient_ui = ITEM_UI.instantiate() as TextureRect
		ingredient_ui.texture = PLACEHOLDER_ICON if is_placeholder else ingredient.icon
		ingredients_container.add_child(ingredient_ui)
	pass

func init(recipe: Recipe, placeholder: bool = false):
	self.recipe = recipe
	is_placeholder = placeholder
	
