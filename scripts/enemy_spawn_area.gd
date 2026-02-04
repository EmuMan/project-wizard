extends Area2D


var rat_node = preload("uid://copx7anmrlqul")
var rz_node = preload("uid://7npbhv7up8w")
var ps_node = preload("uid://dkf120ksnbcf0")
var pb_node = preload("uid://d1c2b64d1f6vv")
@onready var shape: CollisionShape2D = $CollisionShape2D
signal enemy_death

func _on_timer_timeout() -> void:
	spawn_enemy()

func spawn_enemy():
	if SceneManager.current_scene_name == "Level1":
		var enemy = rat_node.instantiate()
		enemy.position = Vector2(
			randf_range(-300+shape.global_position.x, 300+shape.global_position.x),
			randf_range(-300+shape.global_position.y, 300+shape.global_position.y)
		)
		enemy.death.connect(enemy_deaths)
		get_tree().current_scene.add_child(enemy)
		enemy = rz_node.instantiate()
		enemy.position = Vector2(
			randf_range(-300+shape.global_position.x, 300+shape.global_position.x),
			randf_range(-300+shape.global_position.y, 300+shape.global_position.y)
		)
		enemy.death.connect(enemy_deaths)
		get_tree().current_scene.add_child(enemy)
	if SceneManager.current_scene_name == "Level2":
		var enemy = ps_node.instantiate()
		enemy.position = Vector2(
			randf_range(-300+shape.global_position.x, 300+shape.global_position.x),
			randf_range(-300+shape.global_position.y, 300+shape.global_position.y)
		)
		enemy.death.connect(enemy_deaths)
		get_tree().current_scene.add_child(enemy)
		enemy = pb_node.instantiate()
		enemy.position = Vector2(
			randf_range(-300+shape.global_position.x, 300+shape.global_position.x),
			randf_range(-300+shape.global_position.y, 300+shape.global_position.y)
		)
		enemy.death.connect(enemy_deaths)
		get_tree().current_scene.add_child(enemy)

func enemy_deaths():
	enemy_death.emit()
