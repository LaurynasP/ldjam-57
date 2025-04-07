extends Station
class_name ResourceStation

@export var resource: Item

func _ready() -> void:
	super()
	inventory.append(resource)
	ui.station_ui.update_ui(inventory)
	ui.visible = true

func add_item(item: Item) -> bool:
	if item.name != resource.name: return false
	play_add_remove_sound_effect()
	return item == resource

func remove_item() -> Item:
	play_add_remove_sound_effect()
	return ItemManager.items[resource.name]

func reset_station():
	inventory = []
