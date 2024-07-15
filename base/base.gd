class_name Base
extends Node3D

@export var max_health: int = 5
var health: int = 5:
	set(new_health):
		health = new_health
		health = clampi(health, 0, max_health)
		if label_3d: 
			label_3d.text = "%s/%s" % [health, max_health]
			label_3d.modulate = lerp(Color.RED, Color.WHITE, float(health)/float(max_health))
		if health <= 0: die()

var is_ready: bool = true

@onready var label_3d: Label3D = $Label3D

func _ready() -> void:
	health = max_health

func take_damage() -> void:
	print('damage dealt to base')
	health -= 1
	
func die() -> void:
	if not is_ready: return
	is_ready = false
	get_tree().reload_current_scene()
