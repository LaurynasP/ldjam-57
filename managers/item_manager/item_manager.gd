extends Node

var items: Dictionary[String, Item]

func _ready() -> void:
	var i = (load("res://configurations/items_database.tres") as Items).items
	
	for item in i:
		items[item.name] = item	
