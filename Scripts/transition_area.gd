extends Area2D

@export var room_to: Enums.ROOMS
#@export var room_to: Resource
@export var dir_from: Enums.DIRECTION

var overlapping_players: Array[Pc]

func _ready() -> void:
	body_entered.connect(on_player_entered)
	body_exited.connect(on_player_exited)

func on_player_entered(body: PhysicsBody2D) -> void:
	if (body.owner is not Pc): return
	var pc: Pc = body.owner
	overlapping_players.append(pc)
	if (overlapping_players.size() == Globals.n_players):
		SceneManager.change_scene.call_deferred(room_to, dir_from)

func on_player_exited(body: PhysicsBody2D) -> void:
	if (body.owner is not Pc): return
	var pc: Pc = body.owner
	overlapping_players.erase(pc)
