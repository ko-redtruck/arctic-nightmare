extends Node


# Declare member variables here. Examples:
# var a = 2
# var b = "text"


# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.

func pick_up_on(player):
	print("Picked up by", player)
	self.get_parent().remove_child(self)
	player.equip(self)
	
func use_on(player):
	print("Used on", player)
	
func is_usable():
	print("is Usable")
	return true
