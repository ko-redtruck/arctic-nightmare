extends "res://scenes/items/Item.gd"

func is_usable():
	return false

func _ready():
	self.voice_lines =  ["wilson_1", "wilson_2"]
