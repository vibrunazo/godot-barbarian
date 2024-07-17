class_name DifficultyManager
extends Node

@export var game_length: float = 30.0
@export var spawn_time_curve: Curve

@onready var timer: Timer = $Timer


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	timer.start(game_length)

func game_progress_ratio() -> float:
	return 1.0 - (timer.time_left / game_length)

func get_spawn_time() -> float:
	if not spawn_time_curve: return 2
	return spawn_time_curve.sample(game_progress_ratio())
