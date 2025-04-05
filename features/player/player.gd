class_name Player
extends CharacterBody3D

@export var device_id: int = -1
var speed := 5.0
var dash_speed := 15.0
var dash_time := 0.2
var dash_cooldown := 1.5

var is_dashing := false
var dash_timer := 0.0
var dash_cooldown_timer := 0.0

var dash_sound_effect: AudioStream = preload("res://assets/sound/sound_effects/dash.mp3")

func _physics_process(delta: float):
	_handle_movement(delta)

	if InputManager.is_interact_just_pressed(device_id):
		interact()
		
func _handle_movement(delta: float):
	var dir = InputManager.get_input_vector(device_id)
	var move_speed = dash_speed if is_dashing else speed
	
	if not is_on_floor():
		velocity.y -= ProjectSettings.get_setting("physics/3d/default_gravity") * delta
	else:
		velocity.y = 0.0
		

	if is_dashing:
		dash_timer -= delta
		if dash_timer <= 0.0:
			is_dashing = false
	else:
		dash_cooldown_timer -= delta
		if dash_cooldown_timer <= 0.0 and InputManager.is_dash_just_pressed(device_id):
			SoundManager.play_sfx(dash_sound_effect)
			is_dashing = true
			dash_timer = dash_time
			dash_cooldown_timer = dash_cooldown

	velocity.x = dir.x * move_speed
	velocity.z = dir.y * move_speed
	var a = Vector3(dir.x, 0, dir.y)
	
	if dir.length() > 0.01:
		look_at(global_position + a)

	move_and_slide()

func interact():
	print("Device %d interacts" % device_id)
