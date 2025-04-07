extends Node

const DEADZONE = 0.2
const KEYBOARD_ID = -1

enum InputAction { MOVE, DASH, INTERACT }

var available_devices: Array[int] = []
var _joy_button_states: Dictionary = {}


func _ready() -> void:
	process_mode = ProcessMode.PROCESS_MODE_ALWAYS
	
	available_devices.append(KEYBOARD_ID)
	Input.joy_connection_changed.connect(_on_joy_connection_changed)

func _process(_delta: float) -> void:
	_track_joy_buttons()
	

	
func _unhandled_input(event):
	if event.is_action_pressed("ui_cancel"):
		GameManager.toggle_pause()


func get_input_vector(device_id: int) -> Vector2:
	if device_id == -1:
		var x = int(Input.is_action_pressed("keyboard_right")) - int(Input.is_action_pressed("keyboard_left"))
		var y = int(Input.is_action_pressed("keyboard_down")) - int(Input.is_action_pressed("keyboard_up"))
		return Vector2(x, y).normalized()
	else:
		var axis = Vector2(
			Input.get_joy_axis(device_id, JOY_AXIS_LEFT_X),
			Input.get_joy_axis(device_id, JOY_AXIS_LEFT_Y)
		)
		return axis.normalized() if axis.length() > DEADZONE else Vector2.ZERO

func is_dash_just_pressed(device_id: int) -> bool:
	if device_id == KEYBOARD_ID:
		return Input.is_action_just_pressed("keyboard_dash")
	else:
		return _is_joy_button_just_pressed(device_id, JOY_BUTTON_X)

func is_interact_just_pressed(device_id: int) -> bool:
	if device_id == KEYBOARD_ID:
		return Input.is_action_just_pressed("keyboard_interact")
	else:
		return _is_joy_button_just_pressed(device_id, JOY_BUTTON_A)
		
func is_join_just_pressed(device_id: int) -> bool:
	if device_id == KEYBOARD_ID:
		return Input.is_action_just_pressed("keyboard_join")
	else:
		return _is_joy_button_just_pressed(device_id, JOY_BUTTON_Y)
		
func is_add_remove_item_just_pressed(device_id: int) -> bool:
	if device_id == KEYBOARD_ID:
		return Input.is_action_just_pressed("keyboard_add_remove_item")
	else:
		return _is_joy_button_just_pressed(device_id, JOY_BUTTON_B)
		
func is_context_menu_just_pressed(device_id: int) -> bool:
	if device_id == KEYBOARD_ID:
		return Input.is_action_just_pressed("keyboard_tab")
	else:
		return _is_joy_button_just_pressed(device_id, JOY_BUTTON_MISC1)
		
func is_context_menu_just_released(device_id: int) -> bool:
	if device_id == KEYBOARD_ID:
		return Input.is_action_just_released("keyboard_tab")
	else:
		# TODO: Track joy button release properly
		return _is_joy_button_just_pressed(device_id, JOY_BUTTON_MISC1)
		
		
func _track_joy_buttons():
	for device_id in InputManager.available_devices:
		if not _joy_button_states.has(device_id):
			_joy_button_states[device_id] = {}

		for button in range(JOY_BUTTON_MAX):
			var is_pressed = Input.is_joy_button_pressed(device_id, button)
			_joy_button_states[device_id][button] = is_pressed

func _is_joy_button_just_pressed(device_id: int, button: int) -> bool:
	var was_pressed = _joy_button_states.get(device_id, {}).get(button, false)
	var is_pressed = Input.is_joy_button_pressed(device_id, button)
	return is_pressed and not was_pressed
	
func _on_joy_connection_changed(_device_id: int, _connected: bool):
	if _connected:
		if not _joy_button_states.has((_device_id)):
			_joy_button_states[_device_id] = {}
		if not available_devices.has(_device_id):
			available_devices.append(_device_id)
	else:
		if _joy_button_states.has(_device_id):
			_joy_button_states.erase(_device_id)
		if available_devices.has(_device_id):
			available_devices.erase(_device_id)
		
		
