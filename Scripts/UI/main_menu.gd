extends Control

@export var play_btn: Button
@export var room_01: Resource

func _ready() -> void:
	play_btn.pressed.connect(on_play_pressed)
	play_btn.grab_focus()
	play_btn.pressed.emit.call_deferred()

func on_play_pressed() -> void:
	SceneManager.change_scene(Enums.ROOMS.room_00)
