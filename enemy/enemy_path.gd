extends Path3D

## Enemy scene to spawn
@export var enemy_scene: PackedScene
## Time between spawns in seconds
@export var spawn_cooldown: float = 2.0

var spawn_timer: Timer

func _ready() -> void:
	setup_timer()

func setup_timer() -> void:
	spawn_timer = Timer.new()
	add_child(spawn_timer)
	spawn_timer.wait_time = spawn_cooldown
	spawn_timer.timeout.connect(_on_spawn_timer_timeout)
	spawn_timer.start()
	

func spawn_enemy() -> void:
	if not enemy_scene: return
	var new_enemy: Enemy = enemy_scene.instantiate()
	add_child(new_enemy)

func _on_spawn_timer_timeout() -> void:
	spawn_enemy()
