extends PlayerState

func enter(_previous_state_path: String, _data := {}) -> void:
	player.ch.velocity.x = 0.0
	player.anim_player.play("idle")

func physics_update(_delta: float) -> void:
	player.ch.velocity.y += player.ch.get_gravity().y * _delta
	player.ch.move_and_slide()

	if not player.ch.is_on_floor():
		finished.emit(FALLING)
	elif (Input.is_action_just_pressed(player.inputs.move_up) || Input.is_action_just_pressed(player.inputs.move_down)) && player.can_ladder:
		finished.emit(LADDER)
	elif Input.is_action_just_pressed(player.inputs.move_up) && player.can_door:
		finished.emit(DOOR)
	elif Input.is_action_just_pressed(player.inputs.jump):
		finished.emit(JUMPING)
	elif Input.is_action_pressed(player.inputs.move_left) or Input.is_action_pressed(player.inputs.move_right):
		finished.emit(RUNNING)
	elif Input.is_action_just_pressed(player.inputs.attack):
		finished.emit(ATTACKING)
