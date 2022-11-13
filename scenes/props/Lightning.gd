extends Node2D

export var targets = []

func _process(delta):
	while len(get_children()) < len(targets):
		var clone = get_child(0).duplicate()
		clone.process_material = clone.process_material.duplicate(true)
		add_child(clone)
	var center = Vector2()
	for target in targets:
		center += target.global_position
	center /= len(targets)
	global_position = center
	for i in range(len(targets)):
		var target = targets[i]
		var particles = get_child(i)
		var dir = target.global_position - particles.global_position
		particles.process_material.direction = Vector3(dir.x, dir.y, 0)
		particles.process_material.initial_velocity = dir.length() * 5
