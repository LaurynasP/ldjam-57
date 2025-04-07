extends Node

var current_gameplay: Gameplay
var current_level: Level
var selected_player_devices: Array[int] = [-1]

#@onready var menu: Menu = load("res://features/menu/Menu.tscn").instantiate()

signal game_pause_changed(paused: bool)

func _ready() -> void:
	#if not current_level:
		#pause()
	#self.add_child(menu)
	pass
	
func toggle_pause():
	if get_tree().paused: unpause() 
	else: pause()
	
func pause():
	get_tree().paused = true
	emit_signal("game_pause_changed", true)
	
func unpause():
	if get_tree().paused and current_level == null:
		return
	get_tree().paused = false
	emit_signal("game_pause_changed", false)
	
func set_level(level: Level):
	current_level = level
	unpause()
	
func load_level(level: LevelConfiguration):
	LoadingManager._load_level(level)

func add_player_device(device_id: int):
	if current_level == null and device_id not in selected_player_devices:
		selected_player_devices.append(device_id)
		
func remove_player_device(device_id: int):
	if current_level == null and device_id in selected_player_devices:
		selected_player_devices.erase(device_id)
		
func toggle_player_device(device_id: int):
	if device_id in selected_player_devices:
		remove_player_device(device_id)
	else:
		add_player_device(device_id)

func quit_game():
	get_tree().quit()
	
func _get_level_instance() -> Level:
	var levels = get_tree().get_nodes_in_group("level")
	return levels[0] if levels.size() > 0 else null
