extends Station
class_name HandoffStation

var current_order: Order

@onready var label: Label3D = $Label3D
@onready var handoff_station_ui: HandoffStationUI = %HandoffStationUi
@onready var billboard: Sprite3D = %Billboard

var new_order_timeout = 5
var current_new_order_timeout = 0

func _ready() -> void:
	allow_duplicates = true
	inventory_space = 4
	

func _process(delta: float) -> void:
	if not current_order:
		current_new_order_timeout -= delta
		
	if not current_order and current_new_order_timeout <= 0:
		get_new_order()
	
	_handle_current_order()
	
func get_new_order():
	current_order = OrderManager.create_order()
	current_order.order_completed.connect(_handle_completed_or_failed_order)
	current_order.order_failed.connect(_handle_completed_or_failed_order)
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
	
	
func _handle_completed_or_failed_order(order: Order):
	current_new_order_timeout = new_order_timeout
	current_order = null
	_update_ui()
	
	
func _update_ui():
	if current_order != null:
		billboard.visible = true
		handoff_station_ui.update_ui(current_order)
	else:
		billboard.visible = false
		handoff_station_ui.cleanup_ui()
		
	
	
	
