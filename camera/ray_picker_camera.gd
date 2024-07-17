extends Camera3D

@export var turret_manager: TurretManager
@export var turret_cost: float = 100.0

@onready var ray_cast: RayCast3D = $RayCast3D
@onready var bank: Bank = get_tree().get_first_node_in_group("bank")


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	check_cast_under_mouse()
	
func check_cast_under_mouse() -> void:
	if not bank: return
	if bank.gold < turret_cost: return
	var mouse_position: Vector2 = get_viewport().get_mouse_position()
	ray_cast.target_position = project_local_ray_normal(mouse_position) * 100
	ray_cast.force_raycast_update()
	if can_build():
		Input.set_default_cursor_shape(Input.CURSOR_POINTING_HAND)
		if Input.is_action_pressed("click"):
			clicked()
	else:
		Input.set_default_cursor_shape(Input.CURSOR_ARROW)

## Returns whether you can build in whatever cell the ray_cast is colliding with
func can_build() -> bool:
	if not ray_cast.is_colliding(): return false
	var collider := ray_cast.get_collider()
	if collider is GridMap:
		var collision_point: Vector3 = ray_cast.get_collision_point()
		var cell: Vector3i = collider.local_to_map(collision_point)
		if collider.get_cell_item(cell) == 0:
			return true
	return false

func clicked() -> void:
	var collider := ray_cast.get_collider()
	if collider is GridMap:
		var collision_point: Vector3 = ray_cast.get_collision_point()
		var cell: Vector3i = collider.local_to_map(collision_point)
		#printt(cell, collider.get_cell_item(cell))
		if collider.get_cell_item(cell) == 0:
			collider.set_cell_item(cell, 1)
			var cell_position: Vector3 = collider.map_to_local(cell) + collider.global_position
			if turret_manager:
				turret_manager.build_turret(cell_position)
				bank.gold -= turret_cost
				Input.set_default_cursor_shape(Input.CURSOR_ARROW)
