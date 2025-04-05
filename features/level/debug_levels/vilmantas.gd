extends Level

@onready var label = $'Label'

func _ready() -> void:
	label.text += 'Items Count: ' 
	label.text += str(ItemManager.items.size())
	label.text += '\n'
	label.text += 'Recipes Count: '
	label.text += str(RecipeManager.recipes.size())
