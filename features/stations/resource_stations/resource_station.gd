extends Station
class_name ResourceStation

@export var resource: Item

func _ready() -> void:
	super()
	ui.visible = false

func add_item(item: Item) -> bool:
	play_add_remove_sound_effect()
	return item == resource

func remove_item() -> Item:
	play_add_remove_sound_effect()
	return ItemManager.items[resource.name]

func reset_station():
	inventory = []
