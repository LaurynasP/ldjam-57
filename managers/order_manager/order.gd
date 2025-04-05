extends Node
class_name Order

var duration: float
var remaining_duration: float
var items: Items

signal order_completed(order: Order)
signal order_failed(order: Order)

func _init(_duration: float, _items: Items) -> void:
	duration = _duration
	remaining_duration = duration
	items = _items
	

func _process(delta: float) -> void:
	remaining_duration -= delta
	if remaining_duration <= 0:
		fail()
	
func complete() -> void:
	order_completed.emit(self)
	
func fail() -> void:
	order_failed.emit(self)
	
	
