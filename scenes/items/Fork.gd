extends "res://scenes/items/Item.gd"

var group = "Outlet"

func is_usable():
	return is_in_effect_range(group)

func use_on(player):
	var outlet = get_in_effect_range(group)
	if outlet != null:
		var lightning = preload("res://scenes/props/Lightning.tscn").instance()
		lightning.targets.append(player)
		lightning.targets.append(outlet)
		get_node("/root/Game").add_child(lightning)
		player.current_idle_animation = "electrocute"
		yield(get_tree().create_timer(1.5), "timeout")
		player.kill()

func _ready():
	item_name = "fork"
