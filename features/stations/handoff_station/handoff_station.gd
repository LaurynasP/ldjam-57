extends Station
class_name HandoffStation

var current_order: Order

@onready var label: Label3D = $Label3D

func _ready() -> void:
	allow_duplicates = true
	inventory_space = 4

func _process(delta: float) -> void:
	_update_debug_label()
	if not current_order:
		current_order = OrderManager.create_order()
		
	_handle_order()

	
func _update_debug_label():
	label.text = ''
	label.text += 'Inventory: ' + str(inventory.map(func(item: Item): return item.display_name))
	
	if current_order != null:
		label.text += '\n'
		label.text += 'Order: '+ str(current_order.items.map(func(item: Item): return item.display_name))

	
func _handle_order():
	var inventory_duplicate = inventory.duplicate()

	for order_item in current_order.items:
		if order_item not in inventory_duplicate:
			return
		else:
			inventory_duplicate.erase(order_item)
			
			
			
	_complete_order()
	
	
func _complete_order():
	for order_item in current_order.items:
		inventory.erase(order_item)
	
	current_order.complete()
	
	
	
