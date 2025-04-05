extends Resource
class_name Items

@export var items: Array[Item]

var rng = RandomNumberGenerator.new()

func get_random_items(count: int) -> Items:
	var random_items: Items = Items.new()
	if items.is_empty():
		return random_items

	while random_items.size() < count:
		random_items.items.append(get_random_item())
	return random_items

func get_random_item() -> Item:
	if items.is_empty():
		return null
	rng.randomize()
	var item_index = rng.randi_range(0, items.size() - 1)
	return items[item_index]


func set_items(_items: Array[Item]):
	items = _items

func has_item(item: Item) -> bool:
	return item in items
	
func has_all_items(_items: Items) -> bool:
	return items.all(func(item): return item in _items)
	
func add_item(item: Item):
	items.append(item)
	
func remove_item(item: Item) -> bool:
	if has_item(item):
		items.erase(item)
		return true
	else:
		return false
