extends Path3D

## Enemy scene to spawn
@export var enemy_scene: PackedScene
## Reference to the difficulty manager, which calculates spawn cooldown per game time
@export var difficulty_manager: DifficultyManager
## The layer with the win screen that we'll show when we win
@export var victory_layer: VictoryLayer
## Time between spawns in seconds
@export var spawn_cooldown: float = 2.0

var spawn_timer: Timer

func _ready() -> void:
	setup_timer()

func setup_timer() -> void:
	spawn_timer = Timer.new()
	add_child(spawn_timer)
	spawn_timer.wait_time = spawn_cooldown
	#if difficulty_manager:
		#spawn_timer.wait_time = difficulty_manager.get_spawn_time()
	spawn_timer.timeout.connect(_on_spawn_timer_timeout)
	spawn_timer.start()
	
func spawn_enemy() -> void:
	if not enemy_scene: return
	var new_enemy: Enemy = enemy_scene.instantiate()
	new_enemy.max_health = difficulty_manager.get_enemy_health()
	new_enemy.tree_exited.connect(enemy_defeated)
	add_child(new_enemy)
	if difficulty_manager:
		spawn_timer.wait_time = difficulty_manager.get_spawn_time()

func enemy_defeated() -> void:
	if spawn_timer.is_stopped():
		for child in get_children():
			if child is Enemy: return
		win()
		
func win() -> void:
	print("you won")
	if victory_layer: victory_layer.victory()

func _on_spawn_timer_timeout() -> void:
	spawn_enemy()


func _on_difficulty_manager_stop_spawning_enemies() -> void:
	spawn_timer.stop()
