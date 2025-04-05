extends Level

@onready var label = $Label
@onready var furnace_label = $Furnace/Label3D
@onready var furnace = $Furnace as Furnace

func _ready() -> void:
	label.text += 'Items Count: ' 
	label.text += str(ItemManager.items.size())
	label.text += '\n'
	label.text += 'Recipes Count: '
	label.text += str(RecipeManager.recipes.size())
	furnace_label.text = ''
	
	furnace.on_resource_added.connect(on_furnace_resource_added)
	
func on_furnace_resource_added(resource: String):
	print('resource added ' + resource)
