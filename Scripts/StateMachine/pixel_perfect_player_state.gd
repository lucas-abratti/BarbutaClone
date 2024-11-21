class_name PixelPerfectPlayerState
extends State

@export var inputs: PlayerInputs

const IDLE = "Idle"
const RUNNING = "Running"
const JUMPING = "Jumping"
const FALLING = "Falling"
const ATTACKING = "Attacking"

var player: PixelPerfectCharacter

func _ready() -> void:
	await owner.ready
	player = owner as StaticBody2D
	assert(player != null, "The PlayerState state type must be used only in the player scene. It needs the owner to be a Player node.")
