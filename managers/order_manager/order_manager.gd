extends Node

var rng = RandomNumberGenerator.new()
var _available_order_items: Items = Items.new()
var _max_items_per_order: int = 2

var seconds_per_item:float = 30

var order_list: Array[Order] = []

func _ready() -> void:
	var coal = load("res://configurations/items/coal.tres").duplicate()
	var iron = load("res://configurations/items/iron_ore.tres").duplicate()
	_available_order_items.add_item(coal);
	_available_order_items.add_item(iron);
	_available_order_items
	pass
	

func create_order() -> Order:
	rng.randomize()
	var number_of_items: int = rng.randi_range(1, _max_items_per_order)
	var order_duration: float = number_of_items * seconds_per_item
	var items: Items = _available_order_items.get_random_items(number_of_items)
	var order = Order.new(order_duration, items)
	order.order_completed.connect(_handle_completed_order)
	order.order_failed.connect(_handle_failed_order)
	order_list.append(order)
	return order
	

func _handle_completed_order(order: Order):
	_erase_order(order)
	
func _handle_failed_order(order:Order):
	_erase_order(order)
	
func _erase_order(order: Order):
	order_list.erase(order)
	order.queue_free()
	
func set_available_items(items: Array[Item]):
	_available_order_items.set_items(items)
	
func add_available_item(item: Item):
	if not item in _available_order_items.items:
		_available_order_items.add_item(item)

func remove_available_item(item: Item):
	_available_order_items.remove_item(item)
