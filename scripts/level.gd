class_name Level
extends TileMap


onready var spawn_point: Node2D = $SpawnPoint


func get_resource() -> LevelResource:
	var resource = LevelResource.new()
	resource.tileset = get_tileset()
	resource.cell_size = get_cell_size()
	resource.spawn_point = spawn_point.get_position()
	
	var used_size: Vector2 = get_used_rect().size
	for y in range(used_size.y):
		resource.cells.append([])
		for x in range(used_size.x):
			var tile: int = get_cell(x, y)
			resource.cells[y].append(tile)
	return resource


func save(path: String):
	ResourceSaver.save(path, get_resource())


func load_(resource: LevelResource):
	set_tileset(resource.tileset)
	set_cell_size(resource.cell_size)
	spawn_point.set_position(resource.spawn_point)
	
	for y in range(len(resource.cells)):
		for x in range(len(resource.cells[y])):
			var tile: int = resource.cells[y][x]
			set_cell(x, y, tile)
