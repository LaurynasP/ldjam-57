extends Control
class_name LevelSelection

var selected_level: LevelConfiguration

@onready var level_selector: OptionButton = %LevelSelector

@onready var configuration: LevelsConfiguration = load("res://configurations/all_levels.tres")

func _ready():
	_prepare_ui()
	
	level_selector.item_selected.connect(_on_level_selected)

func _on_level_selected(index: int) -> void:
	selected_level = configuration.levels[index]

func _prepare_ui():
	for level in configuration.levels:
		level_selector.add_item(level.name)
		
	level_selector.select(0)
	selected_level = configuration.levels[0]
	
