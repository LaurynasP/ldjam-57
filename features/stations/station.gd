extends Node3D
class_name Station

var inventory: Array[Item] = []

@export var allow_duplicates = false
@export var inventory_space = 1

var ui: StationUIBillboard

signal on_resource_added(resource: Item)

func _ready() -> void:
	var ui_instance = load("res://features/stations/StationUIBillboard.tscn").instantiate()
	ui = ui_instance
	
	var target = find_child('ui_spawn')
	
	if target != null:
		target.add_child(ui_instance)
	else:
		add_child(ui_instance)

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
	
