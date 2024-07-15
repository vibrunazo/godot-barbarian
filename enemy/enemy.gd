class_name Enemy
extends PathFollow3D

## In meters per second
@export var speed: float = 5

@onready var base: Base = get_tree().get_first_node_in_group("base")


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	progress += delta * speed
	if progress_ratio >= 1:
		do_damage()

func do_damage() -> void:
	if base:
		base.take_damage()
		set_process(false)
