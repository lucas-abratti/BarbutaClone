extends Node

signal game_started

var n_players = 1##The number of current local players
var has_game_started: bool
var current_room: Room
	#set(value):
		#current_room = value
		#print("Current room changed")

func start_game() -> void:
	has_game_started = true
	game_started.emit()
