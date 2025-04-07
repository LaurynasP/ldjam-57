extends Control

@export var order_ui_scene: PackedScene
@onready var orders_container := %OrdersContainer

@onready var recipe_overlay := %RecipeOverlay
@onready var recipe_container := %RecipeContainer

@onready var stats_ui := %Stats
@onready var orders_ui := %OrdersPositioner

const RECIPE_UI = preload("res://features/gameplay_ui/recipe_ui/recipe_ui.tscn")

func _ready() -> void:
	GameManager.current_gameplay.on_recipe_screen_toggled.connect(toggle_recipe_screen)
	OrderManager.on_new_order.connect(_handle_new_order)
	
	for recipe in RecipeManager.recipes.values():
		var ui = RECIPE_UI.instantiate() as RecipeUI
		ui.init(recipe	)
		recipe_container.add_child(ui)

func _handle_new_order(order: Order):
	var order_ui = order_ui_scene.instantiate() as OrderUI
	orders_container.add_child(order_ui)
	order_ui.init(order)

func toggle_recipe_screen(show: bool):
	recipe_overlay.visible = show
	
	orders_ui.visible = !show
	stats_ui.visible = !show
	
