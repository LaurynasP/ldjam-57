extends Camera3D
class_name Camera

@export var distance := 10.0
@export var angle_deg := 45.0
@export var height := 10.0
@export var target_position := Vector3.ZERO

func _ready():
	_update_transform()

func _update_transform():
	var angle_rad = deg_to_rad(angle_deg)
	var offset = Vector3(
		distance * cos(angle_rad),
		height,
		distance * sin(angle_rad)
	)
	global_position = target_position + offset
	look_at(target_position, Vector3.UP)
