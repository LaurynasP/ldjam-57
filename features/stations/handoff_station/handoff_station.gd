extends Station
class_name HandoffStation

var current_order: Order

@onready var order_billboard: Sprite3D = %OrderBillboard
@onready var order_billboard_vieport: SubViewport = %OrderBillboardVieport

var order_ui_scene: PackedScene = load("res://features/gameplay_ui/order_ui/OrderUI.tscn")

func _process(_delta: float) -> void:
	if current_order == null:
		find_new_order()
		
	_handle_current_order()
	
func find_new_order():
	for order in OrderManager.order_list:
		if order == null:
			return
		if order.handoff_station == null:
			on_order_found(order)
			return

func on_order_found(order: Order):
	current_order = order
	order.handoff_station = self
	#current_order.order_completed.connect(_handle_completed_or_failed_order)
	#current_order.order_failed.connect(_handle_completed_or_failed_order)
	
	add_order_ui()
	_update_ui()

	
func _handle_current_order():
	if not current_order:
		return
		
	# Validate Order
	var inventory_duplicate = inventory.duplicate()
	for order_item in current_order.items:
		if order_item not in inventory_duplicate:
			return
		else:
			inventory_duplicate.erase(order_item)
	
	# Order is ready
	for order_item in current_order.items:
		inventory.erase(order_item)
	
	current_order.complete()
	
	
#func _handle_completed_or_failed_order(order: Order):
	#
	
func cleanup():
	current_order = null
	_update_ui()
	
func add_order_ui():
	var order_ui = order_ui_scene.instantiate() as OrderUI
	order_billboard_vieport.add_child(order_ui)
	order_ui.init(current_order)

	
func _update_ui():
	if current_order != null:
		order_billboard.visible = true
	else:
		order_billboard.visible = false
		
	
		
	
	
	
