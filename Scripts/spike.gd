@tool
extends Node2D

enum ORIENTATION{
	DOWN,
	TOP,
	LEFT,
	RIGHT,
}

@export var orientation: ORIENTATION:
	set(value):
		orientation = value
		on_orientation_changed()

@export var spike_sprite: Sprite2D

func on_orientation_changed() -> void:
	if (!is_node_ready()): 
		return
	if orientation == ORIENTATION.TOP:
		rotation = PI
	elif orientation == ORIENTATION.DOWN:
		rotation = 0
	elif orientation == ORIENTATION.LEFT:
		rotation = PI/2
	elif orientation == ORIENTATION.RIGHT:
		rotation = PI/-2
