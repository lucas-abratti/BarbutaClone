extends PlayerState

func enter(_previous_state_path: String, _data := {}) -> void:
	print(player.ch.global_position.x)
	player.ch.global_position.x = player.last_ladder.global_position.x
	print(player.ch.global_position.x)
	player.ch.velocity.x = 0.0
	player.anim_player.play("ladder")
	player.ch.collision_mask = 9 #1001

func exit() -> void:
	player.ch.velocity.y = 0
	player.ch.global_position.y += 2
	player.ch.collision_mask = 37 #100101


func physics_update(_delta: float) -> void:
	var input_direction_y := Input.get_axis(player.inputs.move_up, player.inputs.move_down)
	player.ch.velocity.y = player.SPEED * input_direction_y
	player.ch.move_and_slide()
	
	if (input_direction_y == 0):
		player.anim_player.pause()
	else:
		player.anim_player.play()
	
	if !player.can_ladder || input_direction_y == 1 && player.ch.is_on_floor():
		finished.emit(IDLE)
