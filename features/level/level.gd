class_name Level
extends Node

func _enter_tree():
	GameManager.set_level(self)
	print("Entering Level")
	print(GameManager.current_level)
	#var gameplay = ResourceLoader.load("res://features/gameplay/gameplay.tscn")
	#
	#add_child(gameplay.instantiate())

func _ready():
	add_to_group("level")
	pass
