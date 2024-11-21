extends PlayerState

func enter(_previous_state_path: String, _data := {}) -> void:
	SceneManager.change_scene(player.last_door.room_to, Enums.DIRECTION.DOOR)
	finished.emit(IDLE)
