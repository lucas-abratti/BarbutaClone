class_name Pc ##Player Character Class
extends Node2D

@export var inputs: PlayerInputs
@export var ch: CharacterBody2D
@export var weapon_pivot: Node2D
@export var look_ahead_point: Node2D
@export var weapon: HitBox
@export var hurt_box: HurtBox
@export var interaction_check: Area2D
@export var anim_player: AnimationPlayer
@export var hp_bar: HpBar
@export var state_machine: StateMachine

var hp: int = 1:
	set(value):
		hp = value
var max_hp: int = 1
var alive: bool = true
var can_ladder: bool
var can_door: bool
var last_ladder: Node2D
var last_door: Door
const SPEED = 45.0
const JUMP_VELOCITY = 150.0

func _ready() -> void:
	interaction_check.area_entered.connect(on_interaction_area_entered)
	interaction_check.area_exited.connect(on_interaction_area_exited)
	hurt_box.dmg_recieved.connect(recieve_dmg)
	if hp_bar: hp_bar.set_up(hp, max_hp)

func on_interaction_area_entered(area:Area2D) -> void:
	if (area.name.begins_with("Ladder")):
		can_ladder = true
		last_ladder = area
	elif (area.name.begins_with("Door")):
		can_door = true
		last_door = area

##This can brake easly if at any time the player overlaps at least 2 ladders
func on_interaction_area_exited(area:Area2D) -> void:
	if (area.name.begins_with("Ladder")):
		can_ladder = false
	elif (area.name.begins_with("Door")):
		can_door = false

func recieve_dmg(dmg: int) -> void:
	if (!alive): return
	hp -= dmg
	if (hp_bar): hp_bar.change_hp(hp)
	if (hp <= 0):
		alive = false
		state_machine.state.finished.emit(PlayerState.EGG)

func respawn() -> void:
	alive = true
	hp = max_hp

func disable_player() -> void:
		visible = false
		process_mode = PROCESS_MODE_DISABLED

func enable_player() -> void:
		visible = true
		process_mode = PROCESS_MODE_ALWAYS
