extends PixelPerfectPlayerState

func physics_update(delta: float) -> void:
	var motion: Vector2
	motion.x = floor(Input.get_axis(inputs.move_left, inputs.move_right))
	var collision: KinematicCollision2D = player.move(motion)
	#if (collision):
		#print(collision.get_normal())
#
	if not collision:
		finished.emit(FALLING)
	elif Input.is_action_just_pressed(inputs.jump):
		finished.emit(JUMPING)
	#elif Input.is_action_pressed(inputs.move_left) or Input.is_action_pressed(inputs.move_right):
		#finished.emit(RUNNING)
	#elif Input.is_action_just_pressed(inputs.attack):
		#finished.emit(ATTACKING)
