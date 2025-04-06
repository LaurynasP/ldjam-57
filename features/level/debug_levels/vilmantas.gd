extends Level

@onready var label_2 = $Label2
@onready var label_3 = $Label3
@onready var furnace = $furnace as Furnace
@onready var anvil: Anvil = $anvil

@onready var coal_deposit = $coal_deposit as ResourceStation
@onready var iron_deposit = $iron_deposit as ResourceStation

@export var inventory: Array[Item] = []
	
func _process(delta: float) -> void:
	_debug_player_focus()
	_debug_player_item()

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
	
