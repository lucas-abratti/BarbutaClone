extends PixelPerfectPlayerState

func physics_update(delta: float) -> void:
	var motion: Vector2 = Vector2(0, 98) * delta
	player.global_position.y += motion.y
	var collision: KinematicCollision2D = player.move(motion)

	if collision and collision.get_normal() == Vector2.UP:
		finished.emit(IDLE)
	elif Input.is_action_just_pressed(inputs.jump):
		finished.emit(JUMPING)
	elif Input.is_action_pressed(inputs.move_left) or Input.is_action_pressed(inputs.move_right):
		finished.emit(RUNNING)
	elif Input.is_action_just_pressed(inputs.attack):
		finished.emit(ATTACKING)
