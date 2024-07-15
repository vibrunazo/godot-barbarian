class_name Base
extends Node3D

@export var max_health: int = 5
var health: int = 5

@onready var label_3d: Label3D = $Label3D

func _ready() -> void:
	health = max_health
	label_3d.text = str(health)

func take_damage() -> void:
	print('damage dealt to base')
	health -= 1
	health = clampi(health, 0, max_health)
	label_3d.text = str(health)
