extends Node

const DEADZONE = 0.2
const KEYBOARD_ID = -1

enum InputAction { MOVE, DASH, INTERACT }

var available_devices: Array[int] = []

func _ready() -> void:
	process_mode = ProcessMode.PROCESS_MODE_ALWAYS
	Input.joy_connection_changed.connect(_on_joy_connection_changed)
	update_available_devices()

	
func _on_joy_connection_changed(_id: int, _connected: bool):
	update_available_devices()
	
func _unhandled_input(event):
	if event.is_action_pressed("ui_cancel"):
		GameManager.toggle_pause()


func update_available_devices():
	available_devices.clear()
	available_devices.append(KEYBOARD_ID) # always include keyboard
	available_devices += Input.get_connected_joypads()

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
		return Input.is_joy_button_pressed(device_id, JOY_BUTTON_X)

func is_interact_just_pressed(device_id: int) -> bool:
	if device_id == KEYBOARD_ID:
		return Input.is_action_just_pressed("keyboard_interact")
	else:
		return Input.is_joy_button_pressed(device_id, JOY_BUTTON_A)
		
func is_cancel_just_pressed(device_id: int) -> bool:
	if device_id == KEYBOARD_ID:
		return Input.is_action_just_pressed("keyboard_cancel")
	else:
		return Input.is_joy_button_pressed(device_id, JOY_BUTTON_A)
		
