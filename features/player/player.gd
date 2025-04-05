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
@onready var interact_area: Area3D = $InteractArea
@onready var label: Label3D = $Label3D


var item:Item
var stations_in_hit_area: Array[Station] = []
var focused_station: Station

func _ready():
	GameManager.current_gameplay.players[device_id] = self
	interact_area.body_entered.connect(_on_interact_area_entered)
	interact_area.body_exited.connect(_on_interact_area_exited)

func _physics_process(delta: float):
	_handle_movement(delta)
		
func _process(delta: float) -> void:
	debug()
	_handle_input()

func _handle_input():
	if InputManager.is_interact_just_pressed(device_id):
		_interact_action()
	if InputManager.is_add_remove_item_just_pressed(device_id):
		_add_remove_item_action()

func _on_interact_area_entered(body):
	if body is Station:
		stations_in_hit_area.append(body)
		focused_station = stations_in_hit_area[0]
		
		
func _on_interact_area_exited(body):
	if body is Station:
		stations_in_hit_area.erase(body)
		focused_station = null if stations_in_hit_area.size() == 0 else stations_in_hit_area[0]
		
	
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
	
	if dir.length() > 0.01:
		look_at(global_position + Vector3(dir.x, 0, dir.y))

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
		
		
func debug():
	label.text = 'Item: '
	label.text = item.display_name if item != null else "No Item"
