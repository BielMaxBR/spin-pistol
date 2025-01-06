extends Node

var fire_effect_scene = preload("res://scenes/fire_effect.tscn")

func spawn_fire(position, angle, parent, size):
	var inst: Sprite2D = fire_effect_scene.instantiate()
	inst.global_position = position
	inst.rotation = angle
	inst.scale = Vector2(size,size)
	parent.add_child(inst)
