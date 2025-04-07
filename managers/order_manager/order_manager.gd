extends Node

var rng = RandomNumberGenerator.new()
var _available_order_items: Array[Item] = []
var _max_items_per_order: int = 2
var _completed_orders = 0
var _failed_orders = 0
var _score_to_constant_orders:int = 15
var _starting_order_interval:int = 3
var _minimum_order_interval: int = 1
var _time_since_last_order: float = 0
var _generate_orders: bool = false

var seconds_per_item:float = 30

var order_list: Array[Order] = []


signal on_new_order(order: Order)


func _process(delta: float) -> void:
	if GameManager.current_gameplay == null:
		stop_generating_orders()
	
	if not _generate_orders:
		return
		
	_time_since_last_order += delta
	#
		
	var current_order_interval = get_current_order_interval()
	
	if _time_since_last_order >= current_order_interval:
		_create_order()
	
	

	
func setup(level: Level):
	reset()
	_available_order_items = level.ordered_items
	_score_to_constant_orders = level.score_to_constant_orders
	_time_since_last_order = 0 - level.delay_to_first_order
	_starting_order_interval = level.starting_order_interval

	
	
	
func reset():
	_completed_orders = 0
	_failed_orders = 0
	for order in order_list:
		_erase_order(order)


	order_list = []
	
func get_current_order_interval() -> int:
	var score = GameManager.get_score()
	var ratio = float(score) / _score_to_constant_orders
	var interval = _starting_order_interval - ratio
	return max(interval, _minimum_order_interval)


func _create_order() -> Order:
	_time_since_last_order = 0
	rng.randomize()
	var number_of_items: int = rng.randi_range(1, _max_items_per_order)
	var order_duration: float = number_of_items * seconds_per_item
	var items = get_random_items(number_of_items)
	var order = Order.new(order_duration, items)
	order.order_completed.connect(_handle_completed_order)
	order.order_failed.connect(_handle_failed_order)
	order_list.append(order)
	add_child(order)
	on_new_order.emit(order)
	return order
	

func _handle_completed_order(order: Order):
	_completed_orders += 1
	GameManager.add_score(order.items.size())
	_erase_order(order)
	
func _handle_failed_order(order:Order):
	_failed_orders += 1
	_erase_order(order)
	
func _erase_order(order: Order):
	order_list.erase(order)
	order.remove_order()
	
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
	
func stop_generating_orders():
	_generate_orders = false
	
func start_generating_orders():
	reset()
	_generate_orders = true
