extends PlayerState

var attack_duration: float = 0.15
var is_attack_finished: bool
var rotation_target: float

func enter(_previous_state_path: String, _data := {}) -> void:
	is_attack_finished = false
	player.weapon.activate()
	get_tree().create_timer(attack_duration).timeout.connect(on_attack_timer_finished)
	player.weapon_pivot.position.x = 0
	player.anim_player.play("stab")

func on_attack_timer_finished() -> void:
	is_attack_finished = true
	player.weapon.deactivate()

func update(_delta: float) -> void:
	if is_attack_finished:
		finished.emit(IDLE)
	else:
		player.weapon_pivot.position.x = lerp(player.weapon_pivot.position.x, player.weapon_pivot.position.x + 0.25, 0.5)

func physics_update(delta: float) -> void:
	#var input_direction_x := Input.get_axis(player.inputs.move_left, player.inputs.move_right)
	#player.ch.velocity.x = player.SPEED * input_direction_x
	if (player.ch.is_on_floor()):
		player.ch.velocity.x = 0
	player.ch.velocity.y += player.ch.get_gravity().y * delta
	player.ch.move_and_slide()
