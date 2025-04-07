extends Node

var rng = RandomNumberGenerator.new()
var _available_order_items: Array[Item] = []
var _order_item_recipes: Dictionary[Item, Recipe] = {}
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
		
	var current_order_interval = get_current_order_interval()
	
	if _time_since_last_order >= current_order_interval:
		_create_order()
	
func setup(level: Level):
	reset()
	_available_order_items = level.ordered_items
	
	_order_item_recipes = {}
	for order_item in _available_order_items:
		_order_item_recipes[order_item] = RecipeManager.get_recipe_by_product(order_item)
	
	_score_to_constant_orders = level.score_to_constant_orders
	_time_since_last_order = 0 - level.delay_to_first_order
	_starting_order_interval = level.starting_order_interval
	
func reset():
	_completed_orders = 0
	_failed_orders = 0
		
	for order in get_children():
		_erase_order(order as Order)

	order_list = []
	
func get_current_order_interval() -> int:
	var score = GameManager.get_score()
	var ratio = float(score) / _score_to_constant_orders
	var interval = _starting_order_interval - ratio
	return max(interval, _minimum_order_interval)

func _create_order() -> Order:
	var roll = rng.randf()
	var number_of_items = 1 if roll < 0.7 else 2	
	
	var items = get_random_items(number_of_items)

	var total_tier = 0.0
	for item in items:
		var recipe = _order_item_recipes.get(item)
		if recipe != null:
			total_tier += recipe.tier
	
	var avg_tier = total_tier / items.size()
	var tier_delay_multiplier = avg_tier  # e.g. 0.5–2.0
	
	var order_duration = number_of_items * seconds_per_item
	var next_order_interval = get_current_order_interval() * tier_delay_multiplier
	_time_since_last_order = -next_order_interval
	print(_time_since_last_order)
	var order = Order.new(order_duration, items)
	order.order_completed.connect(_handle_completed_order)
	order.order_failed.connect(_handle_failed_order)
	order_list.append(order)
	add_child(order)
	on_new_order.emit(order)
	return order

func _handle_completed_order(order: Order):
	_completed_orders += 1
	var score = 0
	for i in order.items:
		var r = RecipeManager.get_recipe_by_product(i)
		score += r.tier * 10
		
	GameManager.add_score(score)
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
	var items = _available_order_items
	var weights = items.map(func(item):
		var tier = _order_item_recipes.get(item).tier
		return 1.0 / tier
	)
	
	var index = weighted_random_index(weights)
	return items[index]
	
func weighted_random_index(weights: Array) -> int:
	var total = 0.0
	for w in weights: total += w
	
	var roll = rng.randf() * total
	var acc = 0.0
	for i in weights.size():
		acc += weights[i]
		if roll <= acc:
			return i
	return weights.size() - 1
	
func stop_generating_orders():
	_generate_orders = false
	
func start_generating_orders():
	reset()
	_generate_orders = true
