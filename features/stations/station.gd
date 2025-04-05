extends Node3D
class_name Station


var inventory: Array[Item] = []

@export var allow_duplicates = false
@export var inventory_space = 1

signal on_resource_added(resource: Item)

func add_item(item: Item) -> bool:
	if inventory_space <= inventory.size() or (not allow_duplicates and ItemManager.is_item_already_in_inventory(item, inventory)):
		return false
		
	inventory.append(item)
	on_resource_added.emit(item)
	
	return true
	
func interact():
	pass

func remove_item() -> Item:
	return inventory.pop_back()

func reset_station():
	inventory = []
	
