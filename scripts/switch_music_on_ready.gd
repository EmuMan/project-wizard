extends Node

@export var music_name: String = "menu"

func _ready() -> void:
	if music_name == "menu":
		MusicController.play_menu_music()
	elif music_name == "rats":
		MusicController.play_rats_music()
	elif music_name == "penguins":
		MusicController.play_penguins_music()
	elif music_name == "raccoons":
		MusicController.play_raccoons_music()
