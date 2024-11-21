class_name Room
extends Node

@export var respawn_point: Marker2D:
	get():
		if(!respawn_point): return Marker2D.new()
		else: return respawn_point

func _ready() -> void:
	Globals.game_started.connect(on_game_started)
	if !Globals.has_game_started:
		Globals.start_game.call_deferred()
	Globals.current_room = self

func on_game_started() -> void:
	for p in Globals.n_players:
		var c: Pc = PlayerManager.instantiate_new_player(p)
		c.ch.global_position = respawn_point.global_position
