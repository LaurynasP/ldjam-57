extends Node

var rng = RandomNumberGenerator.new()
var _available_order_items: Array[Item] = []
var _max_items_per_order: int = 2

var seconds_per_item:float = 30

var order_list: Array[Order] = []




func _ready() -> void:
	var coal = ItemManager.items["coal"]
	var iron = ItemManager.items["iron_ore"]
	_available_order_items.append(coal);
	_available_order_items.append(iron);
	_available_order_items
	pass
	

func create_order() -> Order:
	rng.randomize()
	var number_of_items: int = rng.randi_range(1, _max_items_per_order)
	var order_duration: float = number_of_items * seconds_per_item
	var items = get_random_items(number_of_items)
	var order = Order.new(order_duration, items)
	order.order_completed.connect(_handle_completed_order)
	order.order_failed.connect(_handle_failed_order)
	order_list.append(order)
	add_child(order)
	return order
	

func _handle_completed_order(order: Order):
	_erase_order(order)
	
func _handle_failed_order(order:Order):
	_erase_order(order)
	
func _erase_order(order: Order):
	order_list.erase(order)
	order.queue_free()
	
func set_available_items(items: Array[Item]):
	_available_order_items = items;
	
func add_available_item(item: Item):
	if not item in _available_order_items:
		_available_order_items.append(item)

func remove_available_item(item: Item):
	_available_order_items.erase(item)
	
func get_random_items(count: int) -> Array[Item]:
	var random_items: Array[Item] = []
	if _available_order_items.size() == 0:
		return random_items

	while random_items.size() < count:
		random_items.append(get_random_item())
	return random_items

func get_random_item() -> Item:
	if _available_order_items.is_empty():
		return null
	rng.randomize()
	var item_index = rng.randi_range(0, _available_order_items.size() - 1)
	return _available_order_items[item_index]
