extends PlayerState

@export var running_frames: Array[Texture2D]

var previouse_input_dir: float = 1

func enter(_previous_state_path: String, _data := {}) -> void:
	player.anim_player.play("run")

func physics_update(delta: float) -> void:
	var input_direction_x := Input.get_axis(player.inputs.move_left, player.inputs.move_right)
	player.ch.velocity.x = player.SPEED * input_direction_x
	player.ch.velocity.y += player.ch.get_gravity().y * delta
	player.ch.move_and_slide()
	if input_direction_x != previouse_input_dir && input_direction_x < 0:
		previouse_input_dir = input_direction_x
		player.ch.scale.x = -1
	elif input_direction_x != previouse_input_dir && input_direction_x > 0:
		previouse_input_dir = input_direction_x
		player.ch.scale.x = -1

	if not player.ch.is_on_floor():
		finished.emit(FALLING)
	elif (Input.is_action_just_pressed(player.inputs.move_up) || Input.is_action_just_pressed(player.inputs.move_down)) && player.can_ladder:
		finished.emit(LADDER)
	elif Input.is_action_just_pressed(player.inputs.jump):
		finished.emit(JUMPING, {"input_dir_x": input_direction_x})
	elif is_equal_approx(input_direction_x, 0.0):
		finished.emit(IDLE)
	elif Input.is_action_just_pressed(player.inputs.attack):
		finished.emit(ATTACKING)
