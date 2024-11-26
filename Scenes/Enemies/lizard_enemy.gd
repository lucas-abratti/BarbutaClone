extends Node2D

@export var hurt_box: HurtBox
@export var lizard_sprite: Sprite2D
@export var lizard_sprite_2: Sprite2D
@export var shot_cooldown: Timer
@export var pickaxe_sprite: AnimatedSprite2D
@export var hit_box: HitBox
@export var shoot_left: bool

var hp: int = 3
var move_speed: float = 50
var dir: int = 1
var has_switched_dir: bool

func _ready() -> void:
	shot_cooldown.timeout.connect(shoot_pickaxe)
	hurt_box.dmg_recieved.connect(on_dmg_recieved)
	hit_box.dmg_delat.connect(on_dmg_dealt)
	if (shoot_left):
		dir = -1
		lizard_sprite.flip_h = true
		lizard_sprite_2.flip_h = true
	pickaxe_sprite.global_position.x = global_position.x + (16*dir)

func _process(delta: float) -> void:
	if (!pickaxe_sprite.visible):
		lizard_sprite.show()
		lizard_sprite_2.hide()
		return
	lizard_sprite.hide()
	lizard_sprite_2.show()
	if ((pickaxe_sprite.global_position.x - global_position.x) * dir > (16 * 4) && !has_switched_dir):
		dir *= -1
		has_switched_dir = true
	elif (!shoot_left && pickaxe_sprite.global_position.x < global_position.x):
		dir *= -1
		disable_pickaxe()
		shot_cooldown.start()
	elif (shoot_left && pickaxe_sprite.global_position.x > global_position.x):
		dir *= -1
		disable_pickaxe()
		shot_cooldown.start()
	pickaxe_sprite.translate(Vector2.RIGHT * move_speed * dir * delta)
	

func on_dmg_dealt(dmg: float) -> void:
	print("Dmg dealt")
	disable_pickaxe()

func on_dmg_recieved(incoming_dmg: float) -> void:
	print("Lizard recieved damage %s " % incoming_dmg)
	hp -= incoming_dmg
	if (hp <= 0):
		disable_lizard.call_deferred()

func shoot_pickaxe() -> void:
	shot_cooldown.stop()
	enable_pickaxe()

func enable_pickaxe() -> void:
	print("Pickaxe enabled")
	has_switched_dir = false
	pickaxe_sprite.visible = true
	pickaxe_sprite.process_mode = Node.PROCESS_MODE_INHERIT

func disable_pickaxe() -> void:
	if(!pickaxe_sprite.visible): return
	print("Pickaxe disabled")
	pickaxe_sprite.global_position.x = global_position.x + (16*dir)
	pickaxe_sprite.visible = false
	pickaxe_sprite.process_mode = PROCESS_MODE_DISABLED

func disable_lizard() -> void:
	visible = false
	process_mode = PROCESS_MODE_DISABLED
