extends Node

var items: Array[Item]

func _ready() -> void:
	items = (load("res://configurations/items_database.tres") as Items).items
	
	for n in range(items.size()):
		items[n].id = n
		
