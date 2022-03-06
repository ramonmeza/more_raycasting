class_name RaycastRenderer
extends ViewportContainer


onready var render_target: RenderTarget = $Viewport/RenderTarget

export var scale: float = 4.0

var level_resource: LevelResource = null


func render(eye_sight: EyeSight):
	var ceilings: PoolVector2Array = []
	var walls: PoolVector2Array = []
	var floors: PoolVector2Array = []
	
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
			
			# todo fix this?
			var x: float = i
			ceilings.append(Vector2(x, ceiling_start))
			ceilings.append(Vector2(x, ceiling_end))
			walls.append(Vector2(x, wall_start))
			walls.append(Vector2(x, wall_end))
			floors.append(Vector2(x, floor_start))
			floors.append(Vector2(x, floor_end))
	
	draw_environment(ceilings, walls, floors)
	render_target.get_viewport().set_size(Vector2(len(rays), get_size().y))


func _process(_delta):
	# stops from rotating with parent node
	set_rotation(0)


func set_level(level: Level):
	level_resource = level.get_resource()


func draw_environment(ceilings: PoolVector2Array,
					  walls: PoolVector2Array,
					  floors: PoolVector2Array):
	render_target.add_layer(ceilings, Color.red)
	render_target.add_layer(walls, Color.green)
	render_target.add_layer(floors, Color.blue)
	render_target.update()
