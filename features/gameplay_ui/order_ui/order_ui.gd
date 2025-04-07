
extends Control
class_name OrderUI

var order: Order
@onready var icon_container: GridContainer = %IconContainer
@onready var timer_bar: TimerBar = %Timer

	
func init(_order: Order) -> void:
	# TODO figure out why OrderUI is crashing without this
	if _order == null or timer_bar == null:
		queue_free()
		return
		
	order = _order
	timer_bar.start_timer(order.duration)
	icon_container.columns = order.items.size()
	for item in order.items:
		var texture_rect = TextureRect.new()
		texture_rect.name = item.display_name + "Icon"
		texture_rect.texture = item.icon
		texture_rect.expand_mode = TextureRect.EXPAND_IGNORE_SIZE
		texture_rect.stretch_mode =TextureRect.STRETCH_KEEP_ASPECT_CENTERED
		texture_rect.size_flags_horizontal = Control.SIZE_FILL | Control.SIZE_EXPAND
		texture_rect.size_flags_vertical = Control.SIZE_FILL | Control.SIZE_EXPAND
		icon_container.add_child(texture_rect)
	order.order_completed.connect(_on_order_deleted)
	order.order_failed.connect(_on_order_deleted)

func _on_order_deleted(order: Order):
	queue_free()
