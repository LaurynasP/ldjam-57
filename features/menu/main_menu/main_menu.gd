extends Node
class_name MainMenu

@onready var play_button:Button = %PlayButton
@onready var settings_button:Button = %SettingsButton
@onready var controls_button:Button = %ControlsButton
@onready var quit_button:Button = %QuitButton

func _ready() -> void:
	process_mode = Node.PROCESS_MODE_WHEN_PAUSED
	
func _process(_delta: float) -> void:
	play_button.text = "Play" if GameManager.current_level == null else "Continue"
	
