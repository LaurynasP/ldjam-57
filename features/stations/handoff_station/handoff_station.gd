extends Station
class_name HandoffStation

var items: Items = Items.new()
var current_order: Order

@onready var label: Label3D = $Label3D

func _process(delta: float) -> void:
	_update_debug_label()
	if not current_order:
		current_order = OrderManager.create_order()
		
	_check_if_order_completed()
	
func _update_debug_label():
	label.text = ''
	label.text += 'Inventory: ' + str(items.items.map(func(item: Item): return item.display_name))
	if current_order != null:
		label.text += '\n'
		label.text += 'Order: '+ str(current_order.items.items.map(func(item: Item): return item.display_name))
		
func _check_if_order_completed():
	if items.has_all_items(current_order.items):
		_complete_order()
	
func _complete_order():
	for order_item in current_order.items:
		items.remove_item(order_item)
	
	current_order.complete()
	
	
	
