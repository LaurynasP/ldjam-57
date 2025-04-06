class_name Gameplay
extends Node

var players: Dictionary[int, Player] = {}

@onready var camera := $PhantomCamera3D

func _ready() -> void:
	GameManager.current_gameplay = self

func _add_player(device_id: int, player: Player) -> void:
	players[device_id] = player
	var something: Array[Node3D] = []
	
	for p in players.values():
		something.append(p as Node3D)
	
	camera.set_follow_targets(something)
