class_name Turret
extends Node3D

@export var projectile_scene: PackedScene

@onready var attack_timer: Timer = $AttackTimer
@onready var spawn_pos: Node3D = %SpawnPos

var enemy_path: Path3D
var target: Enemy

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	attack_timer.timeout.connect(_on_attack_timer)
	attack_timer.start()

func _physics_process(delta: float) -> void:
	rotate_to_target()

func rotate_to_target() -> void:
	if not enemy_path: return
	var enemy: Enemy = find_closest_enemy()
	if not enemy: return
	target = enemy
	look_at(enemy.global_position, Vector3.UP, true)

func find_closest_enemy() -> Enemy:
	var enemy: Enemy
	var best_score: float
	for child in enemy_path.get_children():
		if child is Enemy:
			var distance: float = global_position.distance_to(child.global_position)
			@warning_ignore("unassigned_variable")
			if not enemy:
				enemy = child
				best_score = distance
			elif distance < best_score:
				enemy = child
				best_score = distance
	return enemy

func spawn_projectile() -> void:
	if not target: return
	var new_projectile: Projectile = projectile_scene.instantiate()
	add_child(new_projectile)
	new_projectile.global_position = spawn_pos.global_position
	new_projectile.direction = global_transform.basis.z

func _on_attack_timer() -> void:
	spawn_projectile()
