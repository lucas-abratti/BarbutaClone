@tool
extends Area2D

@export var texture: Texture2D
@onready var top_floor: StaticBody2D = $TopFloor
@onready var area_shape: CollisionShape2D = $CollShape
@onready var ladder_sprites: Node2D = $LadderSprites


@export_range (1, 10) var length: int:
	set(value): 
		length = value
		on_length_changed()

@export var ladder_segments: Array[Sprite2D]

@export var top_offset: float = 1

const segment_height: int = 16

func on_length_changed() -> void:
	if (!is_node_ready()): 
		return
	if (length < ladder_segments.size()):
		for l in ladder_segments:
			if length < ladder_segments.find(l) + 1:
				ladder_segments.erase(l)
				l.queue_free()
	for n in range(length - ladder_segments.size()):
		var s: Sprite2D = Sprite2D.new()
		s.texture = texture
		ladder_sprites.add_child(s)
		ladder_segments.append(s)
		s.position.y = -segment_height * (ladder_segments.size() - 1)
		s.owner = self
	area_shape.shape.size.y = segment_height * ladder_segments.size() + top_offset
	area_shape.position.y = (-8 * ladder_segments.size()) + 8 - (top_offset/2)
	top_floor.position.y = -segment_height * (ladder_segments.size() - 1)

func _ready() -> void:
	on_length_changed()
