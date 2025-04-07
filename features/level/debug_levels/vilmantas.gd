extends Level

var config = load("res://configurations/levels/debug_vilmantas.tres")

func _ready() -> void:
	LoadingManager._load([config.lighting, config.gameplay, config.ui])
	OrderManager.setup(self)
	OrderManager.start_generating_orders()
	super()
