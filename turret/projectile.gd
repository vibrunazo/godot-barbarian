extends Area3D

@export var speed: float = 30.0

var direction: Vector3 = Vector3.FORWARD

func _physics_process(delta: float) -> void:
	position += delta * direction * speed
