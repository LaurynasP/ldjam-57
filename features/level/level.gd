class_name Level
extends Node

func _enter_tree():
	var gameplay = ResourceLoader.load("res://features/gameplay/gameplay.tscn")
	
	add_child(gameplay.instantiate())

func _ready():
	pass
