extends "res://scenes/items/Item.gd"


func use_on(player):
	player.kill()

func is_usable():
	return true

func _ready():
	item_name = "knife"
