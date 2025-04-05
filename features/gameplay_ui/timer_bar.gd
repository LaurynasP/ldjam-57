extends ProgressBar
class_name TimerBar

var total_time := 0.0
var time_left := 0.0


func start_timer(time: float):
	total_time = time
	time_left = time
	max_value = time
	value = time

func _process(delta):
	time_left -= delta
	time_left = max(time_left, 0)
	value = time_left
