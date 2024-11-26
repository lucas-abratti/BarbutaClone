class_name HitBox
extends Area2D

signal dmg_delat(damage: float)

@export var enabled_by_default: bool = true
@export var entity_owner: Node2D

@export var dmg: float = 1

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	if (enabled_by_default):
		activate()
	else:
		deactivate()
	area_entered.connect(on_area_entered)

func on_area_entered(area: Area2D) -> void:
	if area is not HurtBox or area.owner == entity_owner: return
	var hurt_box = area as HurtBox
	hurt_box.recieve_dmg(dmg)
	dmg_delat.emit(dmg)

func activate() -> void:
	set_visible(true)
	set_monitoring(true)

func deactivate() -> void:
	set_visible(false)
	set_monitoring(false)
