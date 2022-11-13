extends RigidBody2D

var item_name

func is_in_effect_range(group: String):
	for node in $EffectRadius.get_overlapping_bodies():
		if node.is_in_group(group):
			return true
	return false

func pick_up_on(player):
	print("Picked up by", player)
	self.get_parent().remove_child(self)
	player.equip(self)

func use_on(player):
	print("Used on", player)

func is_usable():
	# print("is Usable")
	return true
