extends Node2D

@export var up_interval: float = 0.2
@export var down_interval: float = 1
@export var start_on: bool = true
@export var timer: Timer
@export var anim: AnimationPlayer

var current_anim: ANIMS

enum ANIMS{
	SPEAR_UP,
	SPEAR_DOWN,
	SPEAR_HOLD,
}

func _ready() -> void:
	anim.animation_finished.connect(on_animation_finished)
	timer.timeout.connect(on_timer_timeout)
	if (start_on):
		current_anim = ANIMS.SPEAR_DOWN
		anim.play("spear_down")
	else:
		current_anim = ANIMS.SPEAR_HOLD
		timer.start(down_interval)

func on_animation_finished(anim_name: StringName) -> void:
	if (current_anim == ANIMS.SPEAR_DOWN):
		timer.start(down_interval)
	elif (current_anim == ANIMS.SPEAR_UP):
		timer.start(up_interval)

func on_timer_timeout() -> void:
	if (current_anim == ANIMS.SPEAR_DOWN):
		current_anim = ANIMS.SPEAR_HOLD
		timer.start(down_interval)
	elif (current_anim == ANIMS.SPEAR_UP):
		current_anim = ANIMS.SPEAR_DOWN
		anim.play("spear_down")
	elif (current_anim == ANIMS.SPEAR_HOLD):
		current_anim = ANIMS.SPEAR_UP
		anim.play("spear_up")
