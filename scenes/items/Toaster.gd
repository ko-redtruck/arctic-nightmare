extends "res://scenes/items/Item.gd"

func is_usable():
	return is_in_effect_range("Bathtub")

func use_on(player):
	if self.is_usable():
		player.kill()

func _ready():
	item_name = "toaster"
