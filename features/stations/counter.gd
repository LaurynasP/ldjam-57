extends Station
class_name Counter

func _ready() -> void:
	super()
	
func _process(delta: float) -> void:
	ui.station_ui.update_ui(inventory)
