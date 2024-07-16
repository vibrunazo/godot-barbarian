class_name Enemy
extends PathFollow3D

## In meters per second
@export var speed: float = 5
@export var max_health: float = 50

@onready var animation_player: AnimationPlayer = $AnimationPlayer

var health: float = 50:
	set(value):
		if value < health:
			animation_player.play("TakeDamage")
		health = clampf(value, 0, max_health)
		if health <= 0:
			die()

@onready var base: Base = get_tree().get_first_node_in_group("base")

func _ready() -> void:
	health = max_health

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	progress += delta * speed
	if progress_ratio >= 1:
		do_damage()

func do_damage() -> void:
	if base:
		base.take_damage()
		set_process(false)

func die() -> void:
	queue_free()
