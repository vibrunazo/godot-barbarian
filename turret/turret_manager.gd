class_name TurretManager
extends Node3D

@export var turret_scene: PackedScene

func build_turret(turret_position: Vector3) -> void:
	var turret: Node3D = turret_scene.instantiate()
	add_child(turret)
	turret.global_position = turret_position
