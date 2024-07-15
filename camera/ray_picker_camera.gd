extends Camera3D

@onready var ray_cast: RayCast3D = $RayCast3D

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	var mouse_position: Vector2 = get_viewport().get_mouse_position()
	ray_cast.target_position = project_local_ray_normal(mouse_position) * 100
	ray_cast.force_raycast_update()
	if ray_cast.is_colliding():
		var collider := ray_cast.get_collider()
		if collider is GridMap:
			var collision_point: Vector3 = ray_cast.get_collision_point()
			var cell: Vector3i = collider.local_to_map(collision_point)
			printt(cell, collider.get_cell_item(cell))
			if collider.get_cell_item(cell) == 0:
				collider.set_cell_item(cell, 1)
	
