extends ProcessingStation
class_name Furnace

@onready var timer: Timer = $processing_timer

func _ready() -> void:
	timer.timeout.connect(do_processing)
	timer.start()
	
	reset_station()
	super()

func do_processing(increment: int = 5):
	if progress >= 50:
		if available_recipes.size() > 1:
			return
		
		var recipe = available_recipes.values()[0]
		
		if not RecipeManager.can_complete_recipe(recipe, inventory):
			return
		
	super(increment)
	
