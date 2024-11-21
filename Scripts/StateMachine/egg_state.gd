extends PlayerState

var counter: int = 0

func enter(_previous_state_path: String, _data := {}) -> void:
	player.ch.global_position = Globals.current_room.respawn_point.global_position
	player.anim_player.animation_finished.connect(on_anim_finished)
	player.ch.velocity.x = 0.0
	counter = 0
	player.anim_player.play("egg_%s" % counter)

func update(_delta: float) -> void:
	player.ch.velocity.y += player.ch.get_gravity().y * _delta
	player.ch.move_and_slide()
	if (Input.is_action_just_pressed(player.inputs.jump) && !player.anim_player.is_playing()):
		counter += 1
		player.anim_player.play("egg_%s" % counter)

func on_anim_finished(_anim_name: StringName) -> void:
	if (counter == 2):
		player.anim_player.animation_finished.disconnect(on_anim_finished)
		player.respawn()
		finished.emit(IDLE)
