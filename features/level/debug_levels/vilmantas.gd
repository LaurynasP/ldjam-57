extends Level

@onready var label = $Label
@onready var label_2 = $Label2
@onready var label_3 = $Label3
@onready var furnace_label = $Furnace/Label3D
@onready var furnace = $Furnace as Furnace
@onready var anvil: Anvil = $Anvil
@onready var anvil_label = $Anvil/Label3D

@onready var coal_deposit = $coal_deposit as ResourceStation
@onready var iron_deposit = $iron_deposit as ResourceStation

@export var inventory: Array[Item] = []

func _ready() -> void:
	label.text += 'Items Count: ' 
	label.text += str(ItemManager.items.size())
	label.text += '\n'
	label.text += 'Recipes Count: '
	label.text += str(RecipeManager.recipes.size())
	furnace_label.text = ''
	
func _process(delta: float) -> void:
	_debug_player_focus()
	_debug_player_item()
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

func _debug_player_item():
	if GameManager.current_gameplay.players[-1].item != null:
		label_3.text = GameManager.current_gameplay.players[-1].item.name
	else:
		label_3.text = ''
	pass
	
func _debug_player_focus():
	if GameManager.current_gameplay.players[-1].focused_station != null:
		label_2.text = GameManager.current_gameplay.players[-1].focused_station.name
	else:
		label_2.text = ''
	pass
	
