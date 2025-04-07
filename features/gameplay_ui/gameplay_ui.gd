extends Control
class_name GamePlayUI

@export var order_ui_scene: PackedScene
@onready var orders_container := %OrdersContainer

@onready var recipe_overlay := %RecipeOverlay
@onready var recipe_container := %RecipeContainer

@onready var stats_ui := %Stats
@onready var orders_ui := %OrdersPositioner

const RECIPE_UI = preload("res://features/gameplay_ui/recipe_ui/recipe_ui.tscn")

func _ready() -> void:
	GameManager.current_gameplay_ui = self
	GameManager.current_gameplay.on_recipe_screen_toggled.connect(toggle_recipe_screen)
	OrderManager.on_new_order.connect(_handle_new_order)
	
	for recipe: Recipe in RecipeManager.recipes.values():
		var is_placeholder = !OrderManager._available_order_items.any(func(item: Item): return item.name == recipe.product.name) and not is_recipe_required(recipe)
		
		if is_placeholder:
			continue
			
		var ui = RECIPE_UI.instantiate() as RecipeUI
		ui.init(recipe, is_placeholder)
		recipe_container.add_child(ui)

func is_recipe_required(recipe: Recipe) -> bool:
	var product = recipe.product
	
	var all_orders = OrderManager._available_order_items
	
	var order_recipes = []
	
	for r: Recipe in RecipeManager.recipes.values():
		if all_orders.any(func(item: Item): return item.name == r.product.name):
			order_recipes.append(r)
			
	for order_recipe in order_recipes:
		if order_recipe.ingredients.any(func(x: Item): return x.name == product.name):
			return true
		
	return false
		

func _handle_new_order(order: Order):
	var order_ui = order_ui_scene.instantiate() as OrderUI
	orders_container.add_child(order_ui)
	order_ui.init(order)

func toggle_recipe_screen(display: bool):
	recipe_overlay.visible = display
	
	orders_ui.visible = !display
	stats_ui.visible = !display
	
	
