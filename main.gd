extends Node2D


onready var game: Game = $Game
onready var raycast_renderer: RaycastRenderer = $RaycastRenderer
onready var debug_menu: DebugMenu = $DebugMenu


func _ready():
	remove_child(raycast_renderer)
	remove_child(debug_menu)
	game.get_camera().add_child(raycast_renderer)
	game.get_camera().add_child(debug_menu)
	
	raycast_renderer.set_level(game.get_level())
	
	debug_menu.fov_property_slider.connect("value_changed", self, "handle_change", ["fov"])
	debug_menu.distance_property_slider.connect("value_changed", self, "handle_change", ["distance"])

	handle_change(game.get_player().get_eye_sight().fov, "fov")
	handle_change(game.get_player().get_eye_sight().distance, "distance")

func _process(_delta):
	raycast_renderer.render(game.get_player().get_eye_sight())


func handle_change(value: float, property_name: String):
	if property_name == "fov":
		game.get_player().get_eye_sight().fov = value
		
	elif property_name == "distance":
		game.get_player().get_eye_sight().distance = value
