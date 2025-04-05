
extends Control
class_name HandoffStationUI


@onready var icon_container: GridContainer = %IconContainer
@onready var timer_bar: TimerBar = %Timer

func update_ui(order: Order):

	cleanup_ui()
	timer_bar.start_timer(order.duration)
	icon_container.columns = 1 if order.items.size() <= 2 else 2
	for item in order.items:
		var texture_rect = TextureRect.new()
		texture_rect.name = item.display_name + "Icon"
		texture_rect.texture = item.icon
		texture_rect.stretch_mode =TextureRect.STRETCH_KEEP_ASPECT_CENTERED
		texture_rect.size_flags_horizontal = Control.SIZE_FILL | Control.SIZE_EXPAND
		texture_rect.size_flags_vertical = Control.SIZE_FILL | Control.SIZE_EXPAND
		icon_container.add_child(texture_rect)
		
		
func cleanup_ui():
	for child in icon_container.get_children():
		child.queue_free()
		

	
