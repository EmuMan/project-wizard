extends Node2D


@export var kill_goal: int = 10
@export var boss_scene: PackedScene

@onready var progress_bar: ProgressBar = $Camera2D/CanvasLayer/ProgressBar
var kill_count = 0
var boss: Node2D = null
var boss_spawned = false

func _ready() -> void:
	Game.enemy_death.connect(_on_enemy_death)

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta: float) -> void:
	if !boss:
		boss = get_tree().get_first_node_in_group("Bosses")
	
	# TODO: multiple bosses all affect the health bar
	if boss:
		progress_bar.value = boss.health.get_percentage()
	else:
		progress_bar.value = 100.0 * float(kill_count) / float(kill_goal)
	
	if kill_count >= kill_goal and not boss_spawned:
		boss = boss_scene.instantiate()
		get_tree().current_scene.add_child(boss)
		boss_spawned = true

func _on_enemy_death() -> void:
	kill_count += 1
