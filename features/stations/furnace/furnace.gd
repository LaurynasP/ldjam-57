extends Station
class_name Furnace

@export var recipes: Array[Recipe]

@onready var timer: Timer = $Timer

func _ready() -> void:
	loaded_recipes = RecipeManager.get_recipes(recipes)
	
	timer.timeout.connect(do_processing)
	timer.start()
	
	reset_station()
	
