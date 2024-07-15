extends Node3D

@export var projectile_scene: PackedScene

@onready var attack_timer: Timer = $AttackTimer

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	print('turret created')
	attack_timer.timeout.connect(_on_attack_timer)
	attack_timer.start()

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass

func spawn_projectile() -> void:
	var new_projectile: Area3D = projectile_scene.instantiate() as Area3D
	add_child(new_projectile)
	new_projectile.global_position = global_position

func _on_attack_timer() -> void:
	print('attack')
	spawn_projectile()
