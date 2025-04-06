extends ProcessingStation
class_name Anvil

func interact():
	do_processing(11)

func do_processing(increment: int = 5):
	if progress >= 50:
		if RecipeManager.get_completable_recipe(available_recipes.values(), inventory) == null:
			return
		
	super(increment)
