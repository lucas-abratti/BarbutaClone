extends PlayerState

func enter(_previous_state_path: String, _data := {}) -> void:
	player.ch.velocity.x = 0.0
	player.anim_player.play("crouch")
	get_tree().create_timer(0.2).timeout.connect(on_landing_timeout)

func on_landing_timeout() -> void:
	finished.emit(IDLE)
