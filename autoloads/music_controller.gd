extends Node

@onready var menu_music_player: AudioStreamPlayer2D = $MenuMusicPlayer
@onready var rats_music_player: AudioStreamPlayer2D = $RatsMusicPlayer
@onready var penguins_music_player: AudioStreamPlayer2D = $PenguinsMusicPlayer
@onready var raccoons_music_player: AudioStreamPlayer2D = $RaccoonsMusicPlayer

const TARGET_VOLUME_DB = -10.0
const SILENT_VOLUME_DB = -80.0

var current_player: AudioStreamPlayer2D
var is_transitioning = false

var transition_queue: Array[Dictionary] = []

func _ready() -> void:
	_init_volumes()

func _process(_delta: float) -> void:
	if not is_transitioning and len(transition_queue) > 0:
		var transition = transition_queue.pop_front()
		_transition(transition)

func _init_volumes():
	menu_music_player.volume_db = SILENT_VOLUME_DB
	rats_music_player.volume_db = SILENT_VOLUME_DB
	penguins_music_player.volume_db = SILENT_VOLUME_DB
	raccoons_music_player.volume_db = SILENT_VOLUME_DB

func play_menu_music(transition_duration: float):
	_queue_transition(menu_music_player, transition_duration)

func play_rats_music(transition_duration: float):
	_queue_transition(rats_music_player, transition_duration)

func play_penguins_music(transition_duration: float):
	_queue_transition(penguins_music_player, transition_duration)

func play_raccoons_music(transition_duration: float):
	_queue_transition(raccoons_music_player, transition_duration)

func silence_music(transition_duration: float):
	_queue_transition(null, transition_duration)

func _queue_transition(target_player: AudioStreamPlayer2D, duration: float):
	self.transition_queue.append({
		"target": target_player,
		"duration": duration,
	})

func _transition(transition: Dictionary):
	var target_player = transition["target"]
	var duration = transition["duration"]
	
	if target_player == current_player:
		return
	
	if is_transitioning:
		return
	
	is_transitioning = true
	var previous_player = current_player
	current_player = target_player
	
	var elapsed = 0.0
	while elapsed < duration:
		elapsed += get_process_delta_time()
		var t = clamp(elapsed / duration, 0.0, 1.0)
		
		# equal power crossfade
		var fade_in_gain = sin(t * PI / 2.0)
		var fade_out_gain = cos(t * PI / 2.0)
		
		if target_player:
			target_player.volume_db = linear_to_db(fade_in_gain) + TARGET_VOLUME_DB
		if previous_player:
			previous_player.volume_db = linear_to_db(fade_out_gain) + TARGET_VOLUME_DB
		
		await get_tree().process_frame
	
	if target_player:
		target_player.volume_db = TARGET_VOLUME_DB
	if previous_player:
		previous_player.volume_db = SILENT_VOLUME_DB
	
	is_transitioning = false
