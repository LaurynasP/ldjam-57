extends Control
class_name Menu


@onready var main_menu: MainMenu = %MainMenu

@onready var submenus_container: Control = %SubMenus
@onready var play_menu: PlayMenu = %PlayMenu
@onready var options_menu: OptionsMenu = %OptionsMenu
@onready var controls_menu: ControlsMenu = %ControlsMenu

func _ready():
	GameManager.pause()

	main_menu.play_button.grab_focus()
	process_mode = ProcessMode.PROCESS_MODE_WHEN_PAUSED
	
	main_menu.play_button.pressed.connect(_on_play_button_pressed)
	main_menu.settings_button.pressed.connect(_on_settings_button_pressed)
	main_menu.controls_button.pressed.connect(_on_controls_button_pressed)
	main_menu.quit_button.pressed.connect(_on_quit_button_pressed)
	
	GameManager.game_pause_changed.connect(game_pause_changed_handler)

func game_pause_changed_handler(paused: bool):
	submenus_container.visible = false
	main_menu.play_button.grab_focus()
	visible = paused

func _on_play_button_pressed():
	if GameManager.current_level != null:
		GameManager.toggle_pause()
	else:
		play_menu.open()
	
func _on_settings_button_pressed():
	print('www')
	options_menu.open()
	
func _on_controls_button_pressed():
	controls_menu.open()

func _on_quit_button_pressed():
	GameManager.quit_game()
	
