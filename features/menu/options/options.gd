extends Control
class_name Options

@onready var master_volume_slider =%MasterVolumeSlider
@onready var music_volume_slider: HSlider = %MusicVolumeSlider
@onready var sfx_volume_slider: HSlider = %SFXVolumeSlider

@onready var res_dropdown = %ResolutionsDropdown
@onready var display_mode_dropdown = %DisplayModeDropdown

var resolutions = [
	Vector2i(1280, 720),
	Vector2i(1600, 900),
	Vector2i(1920, 1080),
	Vector2i(2560, 1440),
	Vector2i(3840, 2160),
]

func _ready():
	_init_audio_options()
	_init_video_options()
	
func _init_video_options():
	for res in resolutions:
		res_dropdown.add_item("%dx%d" % [res.x, res.y])
		
	res_dropdown.item_selected.connect(_on_resolution_selected)
	
	
	display_mode_dropdown.add_item("Windowed")
	display_mode_dropdown.add_item("Borderless")
	display_mode_dropdown.add_item("Fullscreen")
	display_mode_dropdown.item_selected.connect(_on_window_mode_selected)
	
func _on_window_mode_selected(index):
	match index:
		0:
			DisplayServer.window_set_mode(DisplayServer.WINDOW_MODE_WINDOWED)
		1:
			DisplayServer.window_set_mode(DisplayServer.WINDOW_MODE_FULLSCREEN)
		2:
			DisplayServer.window_set_mode(DisplayServer.WINDOW_MODE_EXCLUSIVE_FULLSCREEN)

func _on_resolution_selected(index):
	DisplayServer.window_set_size(resolutions[index])
	
func _init_audio_options():
	master_volume_slider.value_changed.connect(_on_master_volume_changed)
	music_volume_slider.value_changed.connect(_on_music_volume_changed)
	sfx_volume_slider.value_changed.connect(_on_sfx_volume_changed)

	master_volume_slider.min_value = -40
	master_volume_slider.max_value = 0
	music_volume_slider.min_value = -40
	music_volume_slider.max_value = 0
	sfx_volume_slider.min_value = -40
	sfx_volume_slider.max_value = 0

	master_volume_slider.value = AudioServer.get_bus_volume_db(AudioServer.get_bus_index("Music"))
	music_volume_slider.value = AudioServer.get_bus_volume_db(AudioServer.get_bus_index("Music"))
	sfx_volume_slider.value = AudioServer.get_bus_volume_db(AudioServer.get_bus_index("SFX"))
	

func _on_master_volume_changed(value: float):
	AudioServer.set_bus_volume_db(AudioServer.get_bus_index("Master"), value)
	
func _on_music_volume_changed(value: float):
	AudioServer.set_bus_volume_db(AudioServer.get_bus_index("Music"), value)
	
func _on_sfx_volume_changed(value: float):
	AudioServer.set_bus_volume_db(AudioServer.get_bus_index("SFX"), value)
