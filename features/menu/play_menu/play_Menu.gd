extends SubMenu
class_name PlayMenu

@onready var start_button:Button = %StartButton
@onready var level_selection: LevelSelection = %LevelSelection

func _ready() -> void:
	super._ready()
	start_button.pressed.connect(_on_start_button_press)

func _on_start_button_press():
	GameManager.load_level(level_selection.levels.get(level_selection.selected_level))
	
