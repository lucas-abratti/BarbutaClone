class_name Door
extends Area2D

@export var room_to: Enums.ROOMS
@export var direction: Enums.DIRECTION = Enums.DIRECTION.DOOR
@export var pos_to: Vector2

var overlapping_players: Array[Pc]

func _ready() -> void:
	body_entered.connect(on_player_entered)
	body_exited.connect(on_player_exited)

func on_player_entered(body: Node2D) -> void:
	if (body.owner is not Pc): return
	print("Player entered")
	var pc: Pc = body.owner
	overlapping_players.append(body.owner)

func on_player_exited(body: PhysicsBody2D) -> void:
	if (body.owner is not Pc): return
	print("Player exited")
	var pc: Pc = body.owner
	overlapping_players.erase(pc)
