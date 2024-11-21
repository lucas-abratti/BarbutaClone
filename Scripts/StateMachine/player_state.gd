class_name PlayerState extends State

const IDLE = "Idle"
const RUNNING = "Running"
const JUMPING = "Jumping"
const FALLING = "Falling"
const ATTACKING = "Attacking"
const LANDING = "Landing"
const LADDER = "Ladder"
const EGG = "Egg"
const DOOR = "Door"

var player: Pc

func _ready() -> void:
	await owner.ready
	player = owner as Pc
	assert(player != null, "The PlayerState state type must be used only in the player scene. It needs the owner to be a Player node.")
