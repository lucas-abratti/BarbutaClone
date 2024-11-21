class_name PixelPerfectCharacter
extends StaticBody2D

var previouse_pos: Vector2
var current_pos: Vector2

var velocity: Vector2:
	get():
		print(current_pos - previouse_pos)
		return current_pos - previouse_pos

func move(motion: Vector2) -> KinematicCollision2D:
	previouse_pos = current_pos
	var collision: KinematicCollision2D = move_and_collide(motion)
	current_pos = global_position
	return collision
