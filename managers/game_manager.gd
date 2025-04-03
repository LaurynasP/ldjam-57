extends Node

var current_gameplay: Gameplay
var current_level: Level
var selected_player_devices: Array[int] = [-1]

@onready var menu: Menu = load("res://features/menu/Menu.tscn").instantiate()

signal game_pause_changed(paused: bool)

func _ready() -> void:
	DisplayServer.window_set_size(Vector2i(1920, 1080))
	get_tree().paused = true
	self.add_child(menu)
	
func toggle_pause():
	
	if get_tree().paused and current_level == null:
		return


	get_tree().paused = not get_tree().paused
	emit_signal("game_pause_changed", get_tree().paused)
	


func add_player_device(device_id: int):
	if current_level == null and device_id not in selected_player_devices:
		selected_player_devices.append(device_id)
		
func remove_player_device(device_id: int):
	if current_level == null and device_id in selected_player_devices:
		selected_player_devices.erase(device_id)
		

func quit_game():
	get_tree().quit()
