extends Node2D


@onready var rat_king: TargetingEnemy = $RatKing
@onready var progress_bar: ProgressBar = $Camera2D/CanvasLayer/ProgressBar

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	if rat_king:
		progress_bar.value = rat_king.health.health
