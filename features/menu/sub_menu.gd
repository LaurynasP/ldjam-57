extends Control
class_name SubMenu

func _ready() -> void:
	add_to_group("sub_menu")
	visible = false


func hide_all_sub_menus():
	for submenu in get_tree().get_nodes_in_group("sub_menu"):
		submenu.visible = false

func open():
	self.get_parent().visible = true
	hide_all_sub_menus()
	visible = true
	self.grab_focus()
