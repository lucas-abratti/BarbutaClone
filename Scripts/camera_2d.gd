extends Camera2D

@export var players: Array[Pc]

#func _physics_process(delta: float) -> void:
	#var final_pos: Vector2
	#for p in players:
		#if (!p.alive): continue
		#final_pos.x += p.ch.global_position.x
		#final_pos.y += p.ch.global_position.y
		#final_pos.x += p.look_ahead_point.global_position.x
		#final_pos.y += p.look_ahead_point.global_position.y
	#final_pos = final_pos / (players.size() * 2)
	#global_position.x = lerp(global_position.x, final_pos.x, 0.25)
	#global_position.y = lerp(global_position.y, final_pos.y, 0.5)
