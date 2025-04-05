extends Node3D
@export var player_scene: PackedScene

func _ready() -> void:
	spawn_players()

func spawn_players():
	var markers = get_tree().get_nodes_in_group("player_spawn_point_marker")
	print("Spawning players")
	for i in GameManager.selected_player_devices.size():
		print("Spawning player ", GameManager.selected_player_devices[i])
		var player: Player = player_scene.instantiate() as Player
		player.device_id = GameManager.selected_player_devices[i]
		player.global_position = markers[i].global_position
		add_child(player)
		print("Spawning at ", markers[i].global_position)
		
		
		#print()
		#add_child(player)
