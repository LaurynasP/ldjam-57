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

func _physics_process(delta):
	var dir = InputManager.get_input_vector(device_id)
	var move_speed = dash_speed if is_dashing else speed

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
	move_and_slide()

	if InputManager.is_dash_just_pressed(device_id):
		interact()

func interact():
	print("Device %d interacts" % device_id)
