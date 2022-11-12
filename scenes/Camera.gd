extends Camera2D

export var player: NodePath

func _physics_process(delta: float):
	position = lerp(position, get_node(player).position, 0.1)
