extends PixelPerfectPlayerState

func enter(_previous_state_path: String, _data := {}) -> void:
	var motion: Vector2 = Vector2(0, -20)
	var collision: KinematicCollision2D = player.move(motion)

func physics_update(delta: float) -> void:
	var motion: Vector2 = Vector2(0, 98) * delta
	var collision: KinematicCollision2D = player.move(motion)
	if (collision):
		print(collision.get_normal())

	if player.velocity.y > 0:
		finished.emit(FALLING)
	#elif Input.is_action_just_pressed(inputs.jump):
		#finished.emit(JUMPING)
	#elif Input.is_action_pressed(inputs.move_left) or Input.is_action_pressed(inputs.move_right):
		#finished.emit(RUNNING)
	#elif Input.is_action_just_pressed(inputs.attack):
		#finished.emit(ATTACKING)
