extends Station

@export var is_in_use: bool
@export var progress: int
@export var recipes: Array[Recipe]

func _ready() -> void:
	
