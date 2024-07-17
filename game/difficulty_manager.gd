class_name DifficultyManager
extends Node

signal stop_spawning_enemies

@export var game_length: float = 30.0
@export var spawn_time_curve: Curve
@export var enemy_health_curve: Curve

@onready var timer: Timer = $Timer


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	timer.start(game_length)

func game_progress_ratio() -> float:
	return 1.0 - (timer.time_left / game_length)

func get_spawn_time() -> float:
	if not spawn_time_curve: return 2
	return spawn_time_curve.sample(game_progress_ratio())

func get_enemy_health() -> float:
	if not enemy_health_curve: return 50
	return enemy_health_curve.sample(game_progress_ratio())


func _on_timer_timeout() -> void:
	stop_spawning_enemies.emit()
