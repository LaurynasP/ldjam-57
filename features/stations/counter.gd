extends Station
class_name Counter

func _ready() -> void:
	super()
	
func _process(delta: float) -> void:
	ui.station_ui.timer_bar.get_parent().visible = false
	ui.station_ui.update_ui(inventory)
