extends Node

signal scene_changed(dir: Enums.DIRECTION)

func change_scene(room: Enums.ROOMS, dir_from: Enums.DIRECTION = Enums.DIRECTION.RIGHT ) -> void:
	scene_changed.emit(dir_from)
	get_tree().change_scene_to_file(get_room(room))

func get_room(room: Enums.ROOMS) -> String:
	match(room):
		Enums.ROOMS.room_00:
			return "res://Scenes/Rooms/room_00.tscn"
		Enums.ROOMS.room_01:
			return "res://Scenes/Rooms/room_01.tscn"
		Enums.ROOMS.room_02:
			return "res://Scenes/Rooms/room_02.tscn"
		Enums.ROOMS.room_03:
			return "res://Scenes/Rooms/room_03.tscn"
		_:
			return "res://Scenes/test_level.tscn"
