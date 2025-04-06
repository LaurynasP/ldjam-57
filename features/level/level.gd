class_name Level
extends Node

@export var next_level: LevelConfiguration
@export var ordered_items: Array[Item] = []
@export var completed_orders_to_next_level: int = 2
@export var max_failed_orders: int = 2


func _enter_tree():
	GameManager.set_level(self)

func _ready():
	add_to_group("level")
