class_name Projectile
extends Area3D

## Movement speed in meters per second
@export var speed: float = 30.0
## Kills the projectile after this many seconds
@export var duration: float = 2.0
## Damage dealt to enemies
@export var damage: float = 10

var direction: Vector3 = Vector3.FORWARD

func _ready() -> void:
	await get_tree().create_timer(duration).timeout
	queue_free()

func _physics_process(delta: float) -> void:
	position += delta * direction * speed


func _on_area_entered(area: Area3D) -> void:
	var enemy: Node3D = area.owner
	if enemy is Enemy:
		enemy.health -= damage
		queue_free()
