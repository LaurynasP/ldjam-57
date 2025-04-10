extends Node

@onready var loading_screen = load("res://managers/loading_manager/loading_screen.tscn")
@onready var level_host: Node = Node.new()
var _current_level_config: LevelConfiguration

func _ready():
	add_child(level_host)
	level_host.name = 'LevelHost'

func _load(scenes: Array[PackedScene]):
	var loading_screen_instance: LoadingScreen = _show_loading_screen()

	loading_screen_instance.init(scenes)
	
	# _add_scenes_to_root(scenes)
	
	# loading_screen_instance.queue_free()

func _load_level(config: LevelConfiguration):
	_current_level_config = config
	_load([config.level, config.lighting, config.gameplay, config.ui])

func _add_scenes_to_root(scenes: Array[PackedScene]):
	for scene in scenes:
		if scene == null:
			continue
			
		var instance = scene.instantiate()
		
		level_host.add_child(instance)
	
func _show_loading_screen():
	var loading_screen_instance = loading_screen.instantiate()
	
	get_tree().root.add_child(loading_screen_instance)
	
	_cleanup_level()
			
	return loading_screen_instance

func _cleanup_level():
	for child in level_host.get_children():
		level_host.remove_child(child)
		child.queue_free()

func _restart_level():
	if _current_level_config:
		_load_level(_current_level_config)
		
func _exit_level():
	_cleanup_level()
	GameManager.pause()
