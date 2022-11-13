extends "res://scenes/items/Item.gd"

func use_on(player):
	GameState.player_swapped()


func _ready():
	item_name = "mind_swapper"
