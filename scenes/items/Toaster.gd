extends "res://scenes/items/Item.gd"

var group = "Bathtub"

func is_usable():
	return is_in_effect_range(group)

func use_on(player):
	var bathtub = get_in_effect_range(group)
	if bathtub != null:
		var lightning = preload("res://scenes/props/Lightning.tscn").instance()
		lightning.targets.append(player)
		lightning.targets.append(bathtub)
		get_node("/root/Game").add_child(lightning)

func _ready():
	item_name = "toaster"
