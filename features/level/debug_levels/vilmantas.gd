extends Level

@onready var label = $Label
@onready var furnace_label = $Furnace/Label3D
@onready var furnace = $Furnace as Furnace
@onready var anvil: Anvil = $Anvil

func _ready() -> void:
	label.text += 'Items Count: ' 
	label.text += str(ItemManager.items.size())
	label.text += '\n'
	label.text += 'Recipes Count: '
	label.text += str(RecipeManager.recipes.size())
	furnace_label.text = ''
	
	furnace.on_resource_added.connect(on_furnace_resource_added)
	furnace.on_progress_tick.connect(on_progress_tick)
	furnace.on_processing_completed.connect(on_product_completed)
	
	on_furnace_resource_added(ItemManager.items.values()[0])
	
	
func on_furnace_resource_added(resource: Item):
	_debug_furnace()

func _physics_process(delta: float) -> void:
	if InputManager.is_interact_just_pressed(-1):
		if not furnace.add_item(ItemManager.items['coal']):
			furnace.add_item(ItemManager.items['iron_ore'])

func on_progress_tick(progress: int):
	_debug_furnace()
	
func on_product_completed(item: Item):
	_debug_furnace()

func _debug_furnace():
	furnace_label.text = ''
	furnace_label.text += 'Inventory: ' + str(furnace.inventory.map(func(item: Item): return item.display_name))
	furnace_label.text += '\n'
	furnace_label.text += 'Available: ' + str(furnace.available_recipes.keys())
	furnace_label.text += '\n'
	furnace_label.text += 'Progress: ' + str(furnace.progress)
	
	if furnace.prepared_item != null:
		furnace_label.text += '\n'
		furnace_label.text += 'Prepared Item: ' + str(furnace.prepared_item.display_name)
