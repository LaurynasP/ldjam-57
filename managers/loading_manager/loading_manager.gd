extends Node

@onready var loading_screen = load("res://managers/loading_manager/loading_screen.tscn")
@onready var level_host: Node = Node.new()

func _ready() -> void:
	add_child(level_host)
	level_host.name = 'LevelHost'

func _load(scenes: Array[PackedScene]):
	var loading_screen_instance = _show_loading_screen()
	
	_add_scenes_to_root(scenes)
	
	loading_screen_instance.queue_free()

func _load_level(config: LevelConfiguration):
	_load([config.level, config.lighting, config.gameplay, config.ui])

func _add_scenes_to_root(scenes: Array[PackedScene]):
	for scene in scenes:
		if scene == null:
			continue
			
		var instance = scene.instantiate()
		
		level_host.add_child(instance)
	
func _show_loading_screen() -> Node:
	var loading_screen_instance = loading_screen.instantiate()
	
	get_tree().root.add_child(loading_screen_instance)
	
	for child in level_host.get_children():
		child.queue_free()
			
	return loading_screen_instance
