extends Node
class_name Station

var inventory: Array[Item] = []

signal on_resource_added(resource: Item)

func add_item(item: Item) -> bool:
	if ItemManager.is_item_already_in_inventory(item, inventory):
		return false
		
	inventory.append(item)
	on_resource_added.emit(item)
	
	return true

func remove_item() -> Item:
	return inventory.pop_back()

func reset_station():
	inventory = []
