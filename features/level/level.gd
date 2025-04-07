class_name Level
extends Node

@export var next_level: LevelConfiguration
@export var ordered_items: Array[Item] = []
@export var completed_orders_to_next_level: int = 15
@export var max_failed_orders: int = 5
@export var score_to_constant_orders:int = 15
@export var starting_order_interval:int = 10
@export var minimum_order_interval: int = 5
@export var delay_to_first_order: int = 10


func _enter_tree():
	GameManager.set_level(self)

func _ready():
	add_to_group("level")
