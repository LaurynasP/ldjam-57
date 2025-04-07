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
	var dir = DirAccess.open(music_path)
	if dir == null:
		return
	dir.list_dir_begin()
	var file = dir.get_next()
	while file != "":
		if not dir.current_is_dir() and file.get_extension() in ["ogg", "wav", "mp3"]:
			var path = music_path + file
			var stream = load(path)
			if stream is AudioStream:
				music_tracks.append(stream)
		file = dir.get_next()
	dir.list_dir_end()
	
func _process(_delta: float) -> void:
	if play_random_songs and _music_players.size() == 0:
		_play_random_track()
	

func _play_random_track():
	if music_tracks.is_empty():
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
