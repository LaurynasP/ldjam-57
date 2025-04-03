extends Node

var current_gameplay: Gameplay
@onready var menu: Menu = load("res://features/menu/Menu.tscn").instantiate()

signal game_pause_changed(paused: bool)

func _ready() -> void:
	get_tree().paused = true
	self.add_child(menu)
	
func toggle_pause():
	get_tree().paused = not get_tree().paused
	emit_signal("game_pause_changed", get_tree().paused)
