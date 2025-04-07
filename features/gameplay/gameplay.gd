class_name Gameplay
extends Node

var players: Dictionary[int, Player] = {}

@onready var camera: PhantomCamera3D  = $PhantomCamera3D

var score: int = 0;

signal on_recipe_screen_toggled(show: bool)



func _ready() -> void:
	GameManager.current_gameplay = self
	OrderManager.setup(GameManager.current_level)
	_spawn_players()
	OrderManager.start_generating_orders()
	
func _process(_delta: float) -> void:
	if _is_level_completed() and GameManager.current_level.next_level != null:
		OrderManager.stop_generating_orders()
		LoadingManager._load_level(GameManager.current_level.next_level)
	if _is_level_failed():
		_on_level_failed()
			
		
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

func toggle_recipe_screen(show: bool):
	on_recipe_screen_toggled.emit(show)

	
func _is_level_failed():
	return OrderManager._failed_orders >= GameManager.current_level.max_failed_orders

func _on_level_failed():
	if GameManager.current_gameplay_ui != null:
		var fail_screen = load("res://features/gameplay_ui/level_failed_ui/LevelFailedUI.tscn").instantiate()
		GameManager.current_gameplay_ui.add_child(fail_screen)
		get_tree().paused = true
	else:
		LoadingManager._exit_level()
