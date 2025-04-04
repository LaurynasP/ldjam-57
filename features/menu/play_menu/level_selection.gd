extends Control
class_name LevelSelection

var selected_level: String

@onready var level_selector: OptionButton = %LevelSelector

var levels = {
	"Laurynas": "res://features/level/debug_levels/Laurynas.tscn",
	"Vilmantas": "res://features/level/debug_levels/Vilmantas.tscn",
	"Level 1": "res://features/level/levels/Level1.tscn"
}

func _ready():
	for level_name in levels.keys():
		level_selector.add_item(level_name)

	
	level_selector.select(0)
	selected_level = level_selector.get_item_text(0)
	
	level_selector.item_selected.connect(_on_level_selected)

	

func _on_level_selected(index: int) -> void:
	selected_level = level_selector.get_item_text(index)
	print(selected_level)
