extends Node3D
class_name Station

var inventory: Array[Item] = []

@export var allow_duplicates = false
@export var inventory_space = 1
@export var interact_sound_effect: AudioStream
@export var add_remove_sound_effect: AudioStream = load("res://assets/sound/sound_effects/pop.mp3")
@export var crafted_sound_effect: AudioStream

var ui: StationUIBillboard

signal on_resource_added(resource: Item)

func _ready() -> void:
	var ui_instance = load("res://features/stations/StationUIBillboard.tscn").instantiate()
	ui = ui_instance
	add_child(ui_instance)

func add_item(item: Item) -> bool:
	if inventory_space <= inventory.size() or (not allow_duplicates and ItemManager.is_item_already_in_inventory(item, inventory)):
		return false
		
	inventory.append(item)
	on_resource_added.emit(item)
	play_add_remove_sound_effect()
	return true
	
func interact():
	play_interact_sound_effect()
	pass

func remove_item() -> Item:
	var item = inventory.pop_back()
	if item != null:
		play_add_remove_sound_effect()
	return item

func reset_station():
	inventory = []
	
func play_interact_sound_effect():
	if interact_sound_effect != null:
		SoundManager.play_sfx(interact_sound_effect)

func play_crafted_sound_effect():
	if crafted_sound_effect != null:
		SoundManager.play_sfx(crafted_sound_effect)
		
func play_add_remove_sound_effect():
	SoundManager.play_sfx(add_remove_sound_effect)
