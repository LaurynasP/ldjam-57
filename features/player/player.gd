class_name Player
extends CharacterBody3D

@export var device_id: int = -1
var speed := 10
var dash_speed := 30
var dash_time := 0.2
var dash_cooldown := 1.5

var is_dashing := false
var dash_timer := 0.0
var dash_cooldown_timer := 0.0

var dash_sound_effect: AudioStream = preload("res://assets/sound/sound_effects/dash.mp3")
@onready var interact_area: Area3D = $InteractArea

@onready var anim_tree := $W/AnimationTree
@onready var anim_player := $W/AnimationPlayer
@onready var billboard = $StationUiBillboard
@onready var ui = %StationUI
var item:Item
var stations_in_hit_area: Station
var focused_station: Station

func _ready():
	GameManager.current_gameplay._add_player(device_id, self)
	interact_area.body_entered.connect(_on_interact_area_entered)
	interact_area.body_exited.connect(_on_interact_area_exited)

func _physics_process(delta: float):
	_handle_movement(delta)
		
func _process(_delta: float):
	if item != null: 
		if not billboard.visible:
			var input: Array[Item] = [item]
			ui.update_ui(input)
			billboard.visible = true
	else:
		billboard.visible = false
	
	_handle_input()
	
	if InputManager.is_context_menu_just_pressed(device_id):
		GameManager.current_gameplay.toggle_recipe_screen(true)
	
	if InputManager.is_context_menu_just_released(device_id):
		GameManager.current_gameplay.toggle_recipe_screen(false)

func _handle_input():
	if InputManager.is_interact_just_pressed(device_id):
		_interact_action()
	if InputManager.is_add_remove_item_just_pressed(device_id):
		_add_remove_item_action()

func _on_interact_area_entered(body):
	var station = body as Station
	
	if station == null:
		body = body.get_parent()
	
	station = body as Station
	
	if station == null:
		body = body.get_parent()
	
	station = body as Station
		
	if station == null:
		body = body.get_parent()
	
	station = body as Station
	
	if station == null:
		return
	
	if stations_in_hit_area != null: 
		stations_in_hit_area.highlight(false)
	
	stations_in_hit_area = station
	stations_in_hit_area.highlight(true)
	focused_station = stations_in_hit_area
		
func _on_interact_area_exited(body):
	var station = body as Station
	
	if station == null:
		body = body.get_parent()
	
	station = body as Station
	
	if station == null:
		body = body.get_parent()
	
	station = body as Station
		
	if station == null:
		body = body.get_parent()
	
	station = body as Station
	
	if station == null:
		return
	
	if focused_station == station:
		station.highlight(false)
		focused_station = null
		stations_in_hit_area = null

func _handle_movement(delta: float):
	var dir = InputManager.get_input_vector(device_id)
	var move_speed = dash_speed if is_dashing else speed
	
	if dir.is_zero_approx():
		anim_tree.set("parameters/Transition/transition_request", "idle")
	else:
		anim_tree.set("parameters/Transition/transition_request", "walk")
	
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

	velocity.x = lerp(velocity.x, dir.x * move_speed, 0.3)
	velocity.z = lerp(velocity.z, dir.y * move_speed, 0.3)
	
	if dir.length() > 0.01:
		var target_dir = Vector3(dir.x, 0, dir.y).normalized()
		var current_dir = -global_transform.basis.z.normalized()
		var new_dir = current_dir.slerp(target_dir, delta * 10.0)
		look_at(global_position + new_dir, Vector3.UP)

	move_and_slide()

func _interact_action():
	if focused_station == null:
		return
	
	focused_station.interact()
	
func _add_remove_item_action():
	if focused_station == null:
		return
		
	if item != null:
		if focused_station.add_item(item):
			item = null
	else:
		item = focused_station.remove_item()
