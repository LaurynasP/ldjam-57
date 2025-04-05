class_name Gameplay
extends Node

var players: Dictionary[int, Player] = {}

func _ready() -> void:
	GameManager.current_gameplay = self
