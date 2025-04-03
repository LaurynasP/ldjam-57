extends Control
class_name Menu

func _ready():
	process_mode = ProcessMode.PROCESS_MODE_WHEN_PAUSED
	GameManager.game_pause_changed.connect(game_pause_changed_handler)


func game_pause_changed_handler(paused: bool):
	visible = paused
