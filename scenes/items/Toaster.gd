extends "res://scenes/items/Item.gd"

func is_bathtub_in_range():
	for node in $EffectRadius.get_overlapping_bodies():
		if node.is_in_group("Bathtub"):
			return true
	return false
	
func is_usable():
	return self.is_bathtub_in_range()
func use_on(player):
	if self.is_bathtub_in_range():
		player.kill()

func _ready():
	item_name = "toaster"
