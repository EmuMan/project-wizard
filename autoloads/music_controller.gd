extends Node

@onready var menu_music_player: AudioStreamPlayer2D = $MenuMusicPlayer
@onready var rats_music_player: AudioStreamPlayer2D = $RatsMusicPlayer
@onready var penguins_music_player: AudioStreamPlayer2D = $PenguinsMusicPlayer
@onready var raccoons_music_player: AudioStreamPlayer2D = $RaccoonsMusicPlayer

const TARGET_VOLUME_DB = -10.0
const SILENT_VOLUME_DB = -80.0
const FADE_DURATION = 2.0

var current_player: AudioStreamPlayer2D
var is_transitioning = false

func _ready() -> void:
	silence_all()

func silence_all():
	menu_music_player.volume_db = SILENT_VOLUME_DB
	rats_music_player.volume_db = SILENT_VOLUME_DB
	penguins_music_player.volume_db = SILENT_VOLUME_DB
	raccoons_music_player.volume_db = SILENT_VOLUME_DB

func play_menu_music():
	_transition_to(menu_music_player)

func play_rats_music():
	_transition_to(rats_music_player)

func play_penguins_music():
	_transition_to(penguins_music_player)

func play_raccoons_music():
	_transition_to(raccoons_music_player)

func _transition_to(target_player: AudioStreamPlayer2D):
	if target_player == current_player:
		return
	
	if is_transitioning:
		return
	
	is_transitioning = true
	var previous_player = current_player
	current_player = target_player
	
	var elapsed = 0.0
	while elapsed < FADE_DURATION:
		elapsed += get_process_delta_time()
		var t = clamp(elapsed / FADE_DURATION, 0.0, 1.0)
		
		# equal power crossfade
		var fade_in_gain = sin(t * PI / 2.0)
		var fade_out_gain = cos(t * PI / 2.0)
		
		target_player.volume_db = linear_to_db(fade_in_gain) + TARGET_VOLUME_DB
		if previous_player:
			previous_player.volume_db = linear_to_db(fade_out_gain) + TARGET_VOLUME_DB
		
		await get_tree().process_frame
	
	target_player.volume_db = TARGET_VOLUME_DB
	if previous_player:
		previous_player.volume_db = SILENT_VOLUME_DB
	
	is_transitioning = false
