class_name Game
extends Node


onready var level: Level = $Level
onready var player: Player = $Player
onready var camera: Camera2D = $Camera

var action_map: Dictionary = {}


func _ready():
	level.save("res://levels/level00.tres")
	level.load_(ResourceLoader.load("res://levels/level00.tres"))
	player.set_position(level.spawn_point.get_position())

	bind_action("player_move_forward", funcref(player, "move_forward"))
	bind_action("player_move_backward", funcref(player, "move_backward"))
	bind_action("player_strafe_left", funcref(player, "strafe_left"))
	bind_action("player_strafe_right", funcref(player, "strafe_right"))
	bind_action("player_turn_left", funcref(player, "turn_left"))
	bind_action("player_turn_right", funcref(player, "turn_right"))
	
	remove_child(camera)
	player.add_child(camera)


func bind_action(action: String, function: FuncRef):
	action_map[action] = function


func _process(_delta):
	for action in action_map:
		if Input.is_action_pressed(action):
			action_map[action].call_func()

 
func get_player() -> Player:
	return player


func get_camera() -> Camera2D:
	return camera


func get_level() -> Level:
	return level
