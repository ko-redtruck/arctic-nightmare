extends "res://scenes/items/Item.gd"


func is_usable():
	return true

func use_on(player):
	$AudioStreamPlayer2D.playing = not $AudioStreamPlayer2D.playing
	
func _ready():
	self.item_name = "radio"
