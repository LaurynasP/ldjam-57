extends Control
class_name StationUI

@onready var icon_container := %IconContainer
@onready var timer_bar := %Timer

var prev_items: Array[Item]

func _ready() -> void:
	timer_bar.visible = false

func update_ui(items: Array[Item]):
	if items.size() == 0:
		visible = false
		return
	
	if visible && items == prev_items:
		return
	
	prev_items = items
	
	cleanup_ui()
		
	visible = true
	
	icon_container.columns = 1 if items.size() <= 1 else 2
	for item in items:
		if item == null:
			continue
		var texture_rect = TextureRect.new()
		texture_rect.name = item.display_name + "Icon"
		texture_rect.texture = item.icon
		texture_rect.expand_mode = TextureRect.EXPAND_IGNORE_SIZE
		texture_rect.stretch_mode =TextureRect.STRETCH_KEEP_ASPECT_CENTERED
		texture_rect.size_flags_horizontal = Control.SIZE_FILL | Control.SIZE_EXPAND
		texture_rect.size_flags_vertical = Control.SIZE_FILL | Control.SIZE_EXPAND
		icon_container.add_child(texture_rect)
		
		
func cleanup_ui():
	for child in icon_container.get_children():
		child.queue_free()
		
