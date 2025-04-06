extends Control

@onready var stats_label: Label = %StatsLabel

func _process(delta: float) -> void:
	stats_label.text = ''
	
	stats_label.text += 'Completed Orders: '
	stats_label.text += str(OrderManager._completed_orders)
	if GameManager.current_level.completed_orders_to_next_level != 0:
		stats_label.text += '/' + str(GameManager.current_level.completed_orders_to_next_level)
	stats_label.text += '\n'
	
	stats_label.text += 'Failed Orders: '
	stats_label.text += str(OrderManager._failed_orders)
	if GameManager.current_level.max_failed_orders != 0:
		stats_label.text += '/' + str(GameManager.current_level.max_failed_orders)
