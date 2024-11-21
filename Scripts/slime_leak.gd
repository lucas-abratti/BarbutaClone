extends Node2D
@export var timer: Timer
@export var slime_drop: Sprite2D
@export var drop_hit_box: HitBox

func _ready() -> void:
	timer.timeout.connect(on_timer_time_out)
	timer.start()
	drop_hit_box.body_entered.connect(on_body_entered)

func _process(delta: float) -> void:
	if (!slime_drop.visible): return
	slime_drop.global_position.y += 80 * delta

func on_timer_time_out() -> void:
	if (!slime_drop.visible): 
		enable_drop()

func on_body_entered(_body) -> void:
	disable_drop()
	reset_drop()
	timer.start()

func reset_drop() -> void:
	slime_drop.position = Vector2(0,0)

func enable_drop() -> void:
	slime_drop.visible = true
	change_process_mode.call_deferred(slime_drop, PROCESS_MODE_ALWAYS)

func disable_drop() -> void:
	slime_drop.visible = false
	change_process_mode.call_deferred(slime_drop, PROCESS_MODE_DISABLED)

func change_process_mode(node: Node, mode: Node.ProcessMode) -> void:
	node.process_mode = mode
