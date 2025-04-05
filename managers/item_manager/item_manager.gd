extends Node

var items: Dictionary[String, Item]

func _ready() -> void:
	var i = (load("res://configurations/items_database.tres") as Items).items
	
	for item in i:
		items[item.name] = item	

func is_item_already_in_inventory(item: Item, inventory: Array[Item]) -> bool:
	for i in inventory:
		if i.name == item.name:
			return true
	return false
