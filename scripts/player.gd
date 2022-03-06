class_name Player
extends KinematicBody2D

const FORWARD = Vector2.RIGHT
const RIGHT = Vector2.DOWN

export var turn_rate: float = 200.0
export var accel: float = 3000.0
export var max_speed: float = 1000.0

onready var sprite: Sprite = $Sprite
onready var eye_sight: EyeSight = $Sprite/EyeSight setget , get_eye_sight

var _input_vector: Vector2 = Vector2(0.0, 0.0)
var _input_rotation: float = 0.0


func _physics_process(delta):
	var movement_vector: Vector2 = _input_vector
	move_and_slide((movement_vector * accel * delta).clamped(max_speed))


func _process(delta):
	handle_input_vector(delta)
	handle_turn_input(delta)


func handle_input_vector(delta: float):
	# move with friction
	var stop_threshold: float = 0.1
	var friction: float = 10.0
	
	if _input_vector.length() > stop_threshold:
		_input_vector = lerp(_input_vector, Vector2(0.0, 0.0), friction * delta)
	else:
		_input_vector = Vector2(0.0, 0.0)


func handle_turn_input(delta: float):
	# turn
	sprite.rotate(deg2rad(_input_rotation * delta))
	_input_rotation = 0.0



func move_forward():
	_input_vector += FORWARD.rotated(sprite.get_rotation())


func move_backward():
	_input_vector -= FORWARD.rotated(sprite.get_rotation())


func strafe_left():
	_input_vector -= RIGHT.rotated(sprite.get_rotation())


func strafe_right():
	_input_vector += RIGHT.rotated(sprite.get_rotation())


func turn_left():
	_input_rotation = -turn_rate


func turn_right():
	_input_rotation = turn_rate


func get_eye_sight() -> EyeSight:
	return eye_sight
