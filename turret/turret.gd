class_name Turret
extends Node3D

@export var turret_range: float = 10.0
@export var projectile_scene: PackedScene

@onready var attack_timer: Timer = $AttackTimer
@onready var spawn_pos: Node3D = %SpawnPos
@onready var animation_player: AnimationPlayer = $AnimationPlayer

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
	target = find_best_enemy()
	if not target: return
	look_at(target.global_position, Vector3.UP, true)

## Returns the enemy that is closest to the turret
func find_closest_enemy() -> Enemy:
	var enemy: Enemy = null
	var best_score: float
	for child in enemy_path.get_children():
		if child is Enemy:
			var distance: float = global_position.distance_to(child.global_position)
			if distance > turret_range: continue
			if not enemy or distance < best_score:
				enemy = child
				best_score = distance
	return enemy

## Returns the enemy that is furthest in the path
func find_best_enemy() -> Enemy:
	var enemy: Enemy = null
	var best_score: float
	for child in enemy_path.get_children():
		if child is Enemy:
			var distance: float = global_position.distance_to(child.global_position)
			if distance > turret_range: continue
			var progress: float = child.progress
			if not enemy or progress > best_score:
				enemy = child
				best_score = progress
	return enemy

func attack() -> void:
	if not target: return
	spawn_projectile()
	animation_player.play("fire")
	

func spawn_projectile() -> void:
	var new_projectile: Projectile = projectile_scene.instantiate()
	add_child(new_projectile)
	new_projectile.global_position = spawn_pos.global_position
	new_projectile.direction = global_transform.basis.z

func _on_attack_timer() -> void:
	attack()
