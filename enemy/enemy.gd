class_name Enemy
extends PathFollow3D

## In meters per second
@export var speed: float = 5
@export var max_health: float = 50
## How much gold you get for killing an enemy
@export var gold_on_death: float = 15.0

@onready var animation_player: AnimationPlayer = $AnimationPlayer
@onready var base: Base = get_tree().get_first_node_in_group("base")
@onready var bank: Bank = get_tree().get_first_node_in_group("bank")

var health: float = 50:
	set(value):
		if value < health:
			animation_player.play("TakeDamage")
		health = clampf(value, 0, max_health)
		if health <= 0:
			die()


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
	if bank:
		bank.gold += gold_on_death
	queue_free()
