extends Node2D

@export var hurt_box: HurtBox
@export var anim_player: AnimationPlayer
@export var bat_sprite: Sprite2D

const move_speed = 50
var hp = 1
var destination: Vector2

func _ready() -> void:
	anim_player.play("bat_fly")
	hurt_box.dmg_recieved.connect(on_dmg_recieved)
	generate_new_destination()

func _process(delta: float) -> void:
	move_towards_target(destination, delta)

func move_towards_target(target_position: Vector2, delta: float) -> void:
	var direction = (target_position - global_position).normalized()
	var new_position = global_position + direction * move_speed * delta
	if (new_position - target_position).length() < move_speed * delta:
		global_position = target_position
		generate_new_destination()
	else:
		global_position = new_position

func generate_new_destination() -> void:
	destination = Vector2(randi_range(-120, 120), randi_range(-91, 82))

func on_dmg_recieved(incoming_dmg: float) -> void:
	print("Bat recieved damage %s " % incoming_dmg)
	hp -= incoming_dmg
	if (hp <= 0):
		disable_bat.call_deferred()

func disable_bat() -> void:
	visible = false
	process_mode = PROCESS_MODE_DISABLED
