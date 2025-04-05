extends ProcessingStation
class_name Furnace

@onready var timer: Timer = $Timer

func on_ready() -> void:
	timer.timeout.connect(do_processing)
	timer.start()
	
	reset_station()
	
