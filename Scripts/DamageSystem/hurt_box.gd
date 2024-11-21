class_name HurtBox
extends Area2D

signal dmg_recieved(incoming_dmg: float)

var holder: Pc

func recieve_dmg(incoming_dmg: float) -> void:
	dmg_recieved.emit(incoming_dmg)
