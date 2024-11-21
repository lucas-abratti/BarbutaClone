extends PlayerState

var input_dir_x: float

func enter(_previous_state_path: String, data := {}) -> void:
	if (data.has("input_dir_x")):
		input_dir_x = data["input_dir_x"]
	else:
		input_dir_x = 0
	pass
	#player.animation_player.play("fall")

func physics_update(delta: float) -> void:
	if (input_dir_x != 0):
		player.ch.velocity.x = player.SPEED * input_dir_x
	player.ch.velocity.y += player.ch.get_gravity().y * delta
	player.ch.move_and_slide()
	
	if player.ch.is_on_floor():
		finished.emit(LANDING)
	elif Input.is_action_just_pressed(player.inputs.attack):
		finished.emit(ATTACKING)
