extends Control

@onready var restart_button = %RestartButton
@onready var main_menu_button = %MainMenuButton


func _ready() -> void:
	process_mode = Node.PROCESS_MODE_ALWAYS
	restart_button.pressed.connect(_on_restart_click)
	main_menu_button.pressed.connect(_on_main_menu_click)
	
func _on_restart_click():
	LoadingManager._restart_level()
	
func _on_main_menu_click():
	LoadingManager._exit_level()
