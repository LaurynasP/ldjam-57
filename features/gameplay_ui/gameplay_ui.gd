extends Control

@export var order_ui_scene: PackedScene
@onready var orders_container := %OrdersContainer

func _ready() -> void:
	OrderManager.on_new_order.connect(_handle_new_order)


func _handle_new_order(order: Order):
	var order_ui = order_ui_scene.instantiate() as OrderUI
	orders_container.add_child(order_ui)
	order_ui.init(order)



	
