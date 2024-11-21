extends Node

var players: Array[Pc]
var character_scene: PackedScene = preload("res://Scenes/character.tscn")
const INPUTS = [
	preload("res://Scripts/Resources/p1_inputs.tres"),
	preload("res://Scripts/Resources/p2_inputs.tres")
	]

func _ready() -> void:
	SceneManager.scene_changed.connect(on_scene_changed)

func on_scene_changed(dir: Enums.DIRECTION) -> void:
	print("on_scene_changed")
	print(dir)
	for p in players:
		match(dir):
			Enums.DIRECTION.UP:
				change_player_pos(p, Vector2(p.ch.global_position.x, 92))
			Enums.DIRECTION.DOWN:
				change_player_pos(p, Vector2(p.ch.global_position.x, -92))
			Enums.DIRECTION.LEFT:
				change_player_pos(p, Vector2(120, p.ch.global_position.y))
			Enums.DIRECTION.RIGHT:
				change_player_pos(p, Vector2(-120, p.ch.global_position.y))
			Enums.DIRECTION.DOOR:
				change_player_pos.call_deferred(p, p.last_door.pos_to)
		p.enable_player()

func change_player_pos(p: Pc, pos: Vector2) -> void:
	p.ch.global_position = pos

func instantiate_new_player(p: int) -> Pc:
	var c: Pc = character_scene.instantiate()
	add_child(c)
	c.owner = self
	c.inputs = INPUTS[p]
	players.append.call_deferred(c)
	return c
