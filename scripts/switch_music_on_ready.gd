extends Node

@export var music_name: String = "menu"
@export var transition_duration: float = 3.0

func _ready() -> void:
	if music_name == "menu":
		MusicController.play_menu_music(transition_duration)
	elif music_name == "rats":
		MusicController.play_rats_music(transition_duration)
	elif music_name == "penguins":
		MusicController.play_penguins_music(transition_duration)
	elif music_name == "raccoons":
		MusicController.play_raccoons_music(transition_duration)
