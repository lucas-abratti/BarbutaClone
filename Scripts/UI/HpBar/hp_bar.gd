class_name HpBar extends HBoxContainer

@export var frames: Array[Texture2D]
@export var heart_scene: PackedScene

var current_hp: int
var max_hp: int

func set_up(_hp: int, _max_hp: int) -> void:
	current_hp = _hp
	max_hp = _max_hp
	for c in get_children():
		c.queue_free()
	#for n in range(max_hp / 2):
		#add_child(heart_scene.instantiate())

func change_hp(new_hp: int) -> void:
	current_hp = new_hp
	update_hearts_display()

func update_hearts_display() -> void:
	var accounted_hp: float = 0
	for heart: TextureRect in get_children():
		var frame = 0
		for n: int in range(2):
			if accounted_hp == current_hp: 
				heart.texture = frames[frame]
				return
			accounted_hp += 1
			frame += 1
		heart.texture = frames[frame]
