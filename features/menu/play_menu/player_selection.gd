extends Control

@onready var input_icon_rect: PackedScene = load("res://features/menu/general/InputIcon.tscn")
@onready var keyboard_icon:Texture2D = load("res://assets/images/icons/keyboard.png")
@onready var controller_icon: Texture2D = load("res://assets/images/icons/controller.png")

@onready var available_container:VBoxContainer = %AvailableInputsContainer
@onready var selected_container: VBoxContainer = %SelectedInputsContainer

var device_to_rect: Dictionary[int, TextureRect] = {}


func _ready() -> void:
	process_mode = ProcessMode.PROCESS_MODE_WHEN_PAUSED
	
func _process(_delta):
	if not is_visible_in_tree():
		return
	_handle_device_changes()
	_check_interact()
	_sync_ui()
	
	
func _check_interact():
	for device_id in InputManager.available_devices:
		if InputManager.is_join_just_pressed(device_id):
			GameManager.toggle_player_device(device_id)
			
	
func _handle_device_changes():
	for device_id in device_to_rect.keys().duplicate():
		if device_id not in InputManager.available_devices:
			_cleanup_device(device_id)
	
	for device_id in InputManager.available_devices:
		if device_id not in device_to_rect:
			_add_device(device_id)
			
			

func _cleanup_device(device_id: int):
	if device_id in device_to_rect:
		device_to_rect[device_id].queue_free()
		device_to_rect.erase(device_id)
		GameManager.remove_player_device(device_id)
		
func _add_device(device_id: int):
	if device_id not in device_to_rect:
		device_to_rect[device_id] = _create_device_rect(device_id)

func _create_device_rect(device_id: int) -> TextureRect:
	var rect = input_icon_rect.instantiate()
	rect.texture = keyboard_icon if device_id == -1 else  controller_icon
	return rect


func _sync_ui():
	for device_id in device_to_rect:
		var rect := device_to_rect[device_id]
		var is_selected := device_id in GameManager.selected_player_devices
		var target_container := selected_container if is_selected else available_container

		if rect.get_parent() != target_container:
			if rect.get_parent():
				rect.get_parent().remove_child(rect)
			target_container.add_child(rect)
