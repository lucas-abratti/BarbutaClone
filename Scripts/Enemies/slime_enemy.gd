extends Node2D

@export var hurt_box: HurtBox
@export var anim_player: AnimationPlayer
@export var ray_cast_floor_left: RayCast2D
@export var ray_cast_floor_right: RayCast2D
@export var ray_cast_wall_left: RayCast2D
@export var ray_cast_wall_right: RayCast2D
@export var slime_sprite: Sprite2D

var hp = 3
var dir: int = 1
var move_speed: float = 20.0

func _ready() -> void:
	anim_player.play("slime_walk")
	hurt_box.dmg_recieved.connect(on_dmg_recieved)

func _process(delta: float) -> void:
	position.x += (move_speed * delta) * dir
	if (!can_go_left() && can_go_right()):
		dir = 1
		slime_sprite.flip_h = false
	elif (can_go_left() && !can_go_right()):
		dir = -1
		slime_sprite.flip_h = true
	elif (!can_go_left() && !can_go_right()):
		dir = 0
	else:
		dir= dir

func can_go_left() -> bool:
	if (ray_cast_floor_left.is_colliding() && !ray_cast_wall_left.is_colliding()):
		return true
	else:
		return false

func can_go_right() -> bool:
	if (ray_cast_floor_right.is_colliding() && !ray_cast_wall_right.is_colliding()):
		return true
	else:
		return false

func on_dmg_recieved(incoming_dmg: float) -> void:
	print("Slime recieved damage %s " % incoming_dmg)
	hp -= incoming_dmg
	if (hp <= 0):
		disable_slime.call_deferred()

func disable_slime() -> void:
	visible = false
	process_mode = PROCESS_MODE_DISABLED
