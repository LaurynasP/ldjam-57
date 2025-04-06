extends ProcessingStation
class_name Furnace

@onready var timer: Timer = $processing_timer

func _ready() -> void:
	timer.timeout.connect(do_processing)
	timer.start()
	
	reset_station()
	super()
	
