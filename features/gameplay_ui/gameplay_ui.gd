extends Control

@export var order_ui_scene: PackedScene
@onready var orders_container := %OrdersContainer

func _ready() -> void:
	OrderManager.on_new_order.connect(_handle_new_order)


func _handle_new_order(order: Order):
	var order_ui = order_ui_scene.instantiate() as HandoffStationUI
	orders_container.add_child(order_ui)
	order_ui.update_ui(order)
	order.order_completed.connect(func(order: Order): order_ui.queue_free())
	order.order_failed.connect(func(order: Order): order_ui.queue_free())



	
