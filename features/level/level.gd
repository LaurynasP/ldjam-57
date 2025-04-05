class_name Level
extends Node

func _enter_tree():
	GameManager.set_level(self)

func _ready():
	add_to_group("level")
	pass
