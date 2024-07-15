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
	print("Collider: %s, pos: %s" % [ray_cast.get_collider(), ray_cast.get_collision_point()])
	
