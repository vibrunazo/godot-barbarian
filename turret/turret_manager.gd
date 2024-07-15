class_name TurretManager
extends Node3D

@export var turret_scene: PackedScene
@export var enemy_path: Path3D

## Builds a turret at given global position
func build_turret(turret_position: Vector3) -> void:
	var turret: Turret = turret_scene.instantiate() as Turret
	turret.enemy_path = enemy_path
	add_child(turret)
	turret.global_position = turret_position
