class_name EyeSight
extends Node2D


export var fov: float = 90.0
export var distance: float = 2000.0
export var ray_count: int = 90 setget set_ray_count, get_ray_count


func _ready():
	set_ray_count(ray_count)


func create_ray():
	var ray: RayCast2D = RayCast2D.new()
	ray.set_enabled(false)
	ray.set_collision_mask_bit(0, true)
	ray.set_collision_mask_bit(1, true)
	return ray


func _process(_delta):
	var ray_angle: float = 0.0

	# ray_count is horizontal resolution of projection plane into our world
	for i in range(ray_count):
		var ray: RayCast2D = get_child(i)
		ray.set_enabled(true)
		
		# rotate the rays by half fov so we center the projection
		var half_fov_offset: float = fov / 2.0
		var rads: float = deg2rad(ray_angle - half_fov_offset)
		
		# add this value to our rays' lengths. think of it as a boolean add; we add ot to the circle representing our eyesight around the player.
		# adding this "cirlce" to our eyesight "circle" flattens our eyesight rays into a flat project
		var projection_plane_offset: float = 1 / cos(rads)
		
		# get the actual distance to send the ray to
		var dest: Vector2 = Vector2(distance * projection_plane_offset, 0)
		ray.set_cast_to(dest)
		ray.set_rotation(rads)
		
		# get the next ray angle based off of the fov and the amount of rays we want to shoot
		ray_angle += (fov / float(ray_count))


func set_ray_count(value: int):
	ray_count = value
	
	var node_count: int = get_child_count()
	var diff: int = int(abs(ray_count - node_count))
	for _i in range(diff):
		if ray_count > node_count:
			add_child(create_ray())
			
		elif ray_count < node_count:
			var child: Node = get_child(0)
			remove_child(child)
			queue_free()


func get_ray_count() -> int:
	return get_child_count()


func get_rays() -> Array:
	return get_children()


func get_distance() -> float:
	return distance
