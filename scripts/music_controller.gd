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
	silence_all()
	menu_music_player.volume_db = -10.0

func play_rats_music():
	silence_all()
	rats_music_player.volume_db = -10.0

func play_penguins_music():
	silence_all()
	penguins_music_player.volume_db = -10.0

func play_raccoons_music():
	silence_all()
	raccoons_music_player.volume_db = -10.0

func _transition_to(target_player: AudioStreamPlayer2D):
	if target_player == current_player:
		return
	
	if is_transitioning:
		return
	
	is_transitioning = true
	var previous_player = current_player
	current_player = target_player
	
	var tween = create_tween().set_parallel(true)
	
	tween.tween_property(target_player, "volume_db", TARGET_VOLUME_DB, FADE_DURATION)
	if previous_player:
		tween.tween_property(previous_player, "volume_db", SILENT_VOLUME_DB, FADE_DURATION)
	
	await tween.finished
	
	is_transitioning = false
