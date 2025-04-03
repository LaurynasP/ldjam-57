extends Node

#@export var music_volume: float = 1.0
#@export var sfx_volume: float = 1.0

var _music_players: Array[AudioStreamPlayer] = []
var _sfx_players: Array[AudioStreamPlayer] = []

var menu_music: AudioStream = preload("res://assets/sound/music/menu.mp3")

func _ready():
	process_mode = ProcessMode.PROCESS_MODE_ALWAYS
	play_music(menu_music)
	pass

func play_music(stream: AudioStream):
	var player := AudioStreamPlayer.new()
	player.stream = stream
	#player.volume_db = linear_to_db(music_volume)
	player.bus = "Music"
	player.autoplay = false
	add_child(player)
	player.play()
	_music_players.append(player)

func stop_all_music():
	for player in _music_players:
		player.stop()
		player.queue_free()
	_music_players.clear()

func play_sfx(stream: AudioStream):
	print("playing sound")
	var player := AudioStreamPlayer.new()
	player.stream = stream
	#player.volume_db = linear_to_db(sfx_volume)
	player.bus = "SFX"
	player.autoplay = false
	add_child(player)
	player.play()
	_sfx_players.append(player)
	# Remove after finished
	player.finished.connect(func(): 
		_sfx_players.erase(player)
		player.queue_free()
	)

#func set_music_volume(value: float):
	#music_volume = clamp(value, 0.0, 1.0)
	#for player in _music_players:
		#player.volume_db = linear_to_db(music_volume)
#
#func set_sfx_volume(value: float):
	#sfx_volume = clamp(value, 0.0, 1.0)
	#for player in _sfx_players:
		#player.volume_db = linear_to_db(sfx_volume)
