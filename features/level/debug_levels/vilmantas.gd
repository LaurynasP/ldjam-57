extends Level

@onready var label = $Label
@onready var furnace_label = $Furnace/Label3D
@onready var furnace = $Furnace as Furnace
@onready var anvil: Anvil = $Anvil
@onready var anvil_label = $Anvil/Label3D

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
	
	anvil.on_resource_added.connect(on_furnace_resource_added)
	anvil.on_progress_tick.connect(on_progress_tick)
	anvil.on_processing_completed.connect(on_product_completed)
	
	on_furnace_resource_added(ItemManager.items.values()[0])
	
	
func on_furnace_resource_added(resource: Item):
	_debug_furnace()
	_debug_anvil()

func _physics_process(delta: float) -> void:
	if InputManager.is_interact_just_pressed(-1):
		print(anvil.add_item(ItemManager.items['iron_bar']))
		if not anvil.add_item(ItemManager.items['iron_bar']):
			anvil.interact()

func on_progress_tick(progress: int):
	_debug_furnace()
	_debug_anvil()
	
func on_product_completed(item: Item):
	_debug_furnace()
	_debug_anvil()

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


func _debug_anvil():
	anvil_label.text = ''
	anvil_label.text += 'Inventory: ' + str(anvil.inventory.map(func(item: Item): return item.display_name))
	anvil_label.text += '\n'
	anvil_label.text += 'Available: ' + str(anvil.available_recipes.keys())
	anvil_label.text += '\n'
	anvil_label.text += 'Progress: ' + str(anvil.progress)
	
	if anvil.prepared_item != null:
		anvil_label.text += '\n'
		anvil_label.text += 'Prepared Item: ' + str(anvil.prepared_item.display_name)
