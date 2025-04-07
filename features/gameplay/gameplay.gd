class_name Gameplay
extends Node

var players: Dictionary[int, Player] = {}

@onready var camera: PhantomCamera3D  = $PhantomCamera3D

var score: int = 0;

func _ready() -> void:
	GameManager.current_gameplay = self
	OrderManager.setup(GameManager.current_level)
	_spawn_players()
	OrderManager.start_generating_orders()
	
func _process(delta: float) -> void:
	if _is_level_completed() and GameManager.current_level.next_level != null:
		OrderManager.stop_generating_orders()
		LoadingManager._load_level(GameManager.current_level.next_level)

func _is_level_completed() -> bool:
	if GameManager.current_level.next_level == null:
		return false
	
	if OrderManager._completed_orders < GameManager.current_level.completed_orders_to_next_level:
		return false
	
	return true
	

func _add_player(device_id: int, player: Player) -> void:
	players[device_id] = player
	var something: Array[Node3D] = []
	
	for p in players.values():
		something.append(p as Node3D)
	
	camera.set_follow_targets(something)

func _spawn_players():
	var spawner = get_tree().get_first_node_in_group("player_spawner") as PlayerSpawner
	spawner.spawn_all_players()
