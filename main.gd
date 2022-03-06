extends Node2D


onready var game: Game = $Game
onready var raycast_renderer: RaycastRenderer = $RaycastRenderer


func _ready():
	remove_child(raycast_renderer)
	game.get_camera().add_child(raycast_renderer)
	game.get_player().get_eye_sight().distance = 1000
	game.get_player().get_eye_sight().fov = 60.0
	
	raycast_renderer.set_level(game.get_level())

func _process(_delta):
	raycast_renderer.render(game.get_player().get_eye_sight())

