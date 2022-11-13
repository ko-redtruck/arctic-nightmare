extends "res://items/Item.gd"

func use_on(player):
	player.kill()

func is_usable():
	return true
