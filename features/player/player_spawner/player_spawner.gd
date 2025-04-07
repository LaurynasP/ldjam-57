extends Node3D
class_name PlayerSpawner
@export var player_scene: PackedScene

func _ready() -> void:
	add_to_group("player_spawner")

# TODO: Fix spawning. If Y is not 0 the players don't get spawned on the actual target. 

func spawn_all_players():
	var markers = get_tree().get_nodes_in_group("player_spawn_point_marker")

	for i in GameManager.selected_player_devices.size():
		var player: Player = player_scene.instantiate() as Player
		player.device_id = GameManager.selected_player_devices[i]
		player.global_position = markers[i].global_position
		add_child(player)
		
