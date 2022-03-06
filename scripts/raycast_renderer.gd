class_name RaycastRenderer
extends ViewportContainer


onready var render_target: RenderTarget = $Viewport/RenderTarget

export var scale: float = 4.0
export var fog_multiplier: float = 100.0

var level_resource: LevelResource = null


func render(eye_sight: EyeSight):
	if eye_sight == null:
		return
	
	var ceilings: Array = []
	var walls: Array = []
	var floors: Array = []
	
	var rays: Array = eye_sight.get_rays()
	for i in len(rays):
		var ray: RayCast2D = rays[i]
		if ray.is_colliding():
			var dist: float = eye_sight.get_global_position().distance_to(ray.get_collision_point())
			
			var screen_half: float = get_size().y / 2
			var wall_height: float = get_size().y / dist * scale
			
			var ceiling_start: float = 0
			var ceiling_end: float = screen_half - wall_height
			var wall_start: float = ceiling_end
			var wall_end: float = screen_half + wall_height
			var floor_start: float = wall_end
			var floor_end: float = get_size().y
			
			# horizontal distance works, but vertical distance?
			var intensity = get_object_intensity(dist, eye_sight.get_distance()) / dist * fog_multiplier
			
			var x: float = i
			ceilings.append(LineData.new(Vector2(x, ceiling_start), Vector2(x, ceiling_end), Color.red))
			walls.append(LineData.new(Vector2(x, wall_start), Vector2(x, wall_end), Color.green * intensity))
			floors.append(LineData.new(Vector2(x, floor_start), Vector2(x, floor_end), Color.blue))

	draw_environment(ceilings, walls, floors)
	render_target.get_viewport().set_size(Vector2(len(rays), get_size().y))


func _process(_delta):
	# stops from rotating with parent node
	set_rotation(0)


func get_object_intensity(dist: float, max_dist: float) -> float:
	if dist >= max_dist:
		return 0.0
	
	elif dist >= max_dist * 0.75:
		return 0.25
	
	elif dist >= max_dist * 0.5:
		return 0.5
	
	elif dist >= max_dist * 0.25:
		return 0.75
	
	return 1.0

func set_level(level: Level):
	level_resource = level.get_resource()


func draw_environment(ceilings: Array, walls: Array, floors: Array):
	
	render_target.add_lines(ceilings)
	render_target.add_lines(walls)
	render_target.add_lines(floors)
	render_target.update()
