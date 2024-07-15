extends Node3D

@export var turret_scene: PackedScene

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	var turret = turret_scene.instantiate()
	add_child(turret)
