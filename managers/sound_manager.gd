extends Node

var _music_players: Array[AudioStreamPlayer] = []
var _sfx_players: Array[AudioStreamPlayer] = []

var music_path: String = "res://assets/sound/music/"
var music_tracks: Array[AudioStream] = []
var play_random_songs = true

func _ready():
	process_mode = ProcessMode.PROCESS_MODE_ALWAYS
	_load_tracks()
	
func _load_tracks():
	var song1 = load("res://assets/sound/music/song1.mp3")
	music_tracks.append(song1)
	var song2 = load("res://assets/sound/music/song2.mp3")
	music_tracks.append(song2)
	var song3 = load("res://assets/sound/music/song3.mp3")
	music_tracks.append(song3)
	var song4 = load("res://assets/sound/music/song4.mp3")
	music_tracks.append(song4)
	var song5 = load("res://assets/sound/music/song5.mp3")
	music_tracks.append(song5)
	var song6 = load("res://assets/sound/music/song6.mp3")
	music_tracks.append(song6)
	
func _process(_delta: float) -> void:
	_play_random_track()
	

func _play_random_track():
	if _music_players.size() > 0:
		return
		
	var track:AudioStream = music_tracks[randi() % music_tracks.size()]
	play_music(track)
	
	
func play_music(stream: AudioStream):
	var player := AudioStreamPlayer.new()
	player.stream = stream
	player.bus = "Music"
	player.autoplay = false
	add_child(player)
	player.play()
	_music_players.append(player)
	player.finished.connect(func(): 
		_music_players.erase(player)
		player.queue_free()
	)

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
