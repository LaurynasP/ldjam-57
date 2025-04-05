extends Node

var _music_players: Array[AudioStreamPlayer] = []
var _sfx_players: Array[AudioStreamPlayer] = []

var menu_music: AudioStream = preload("res://assets/sound/music/menu.mp3")

func _ready():
	process_mode = ProcessMode.PROCESS_MODE_ALWAYS
	pass

func play_music(stream: AudioStream):
	var player := AudioStreamPlayer.new()
	player.stream = stream
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
	var player := AudioStreamPlayer.new()
	player.stream = stream
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
