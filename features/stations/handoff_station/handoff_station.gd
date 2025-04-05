extends Station
class_name HandoffStation

var items: Items = Items.new()
var current_order: Order

func _process(delta: float) -> void:
	if not current_order:
		current_order = OrderManager.create_order()
		
	_check_if_order_completed()
		
func _check_if_order_completed():
	if items.has_all_items(current_order.items):
		_complete_order()
	
	
	
func _complete_order():
	for order_item in current_order.items:
		items.remove_item(order_item)
	
	current_order.complete()
	
	
	
