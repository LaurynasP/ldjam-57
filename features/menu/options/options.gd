extends Control
class_name Options

@onready var master_volume_slider =%MasterVolumeSlider
@onready var music_volume_slider: HSlider = %MusicVolumeSlider
@onready var sfx_volume_slider: HSlider = %SFXVolumeSlider

func _ready():
	init_audio_options()


func init_audio_options():
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
