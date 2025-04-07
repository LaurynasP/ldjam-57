extends Station
class_name Counter

func _ready() -> void:
	super()
	
func _process(_delta: float) -> void:
	ui.station_ui.timer_bar.get_parent().visible = false
