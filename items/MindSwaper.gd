extends "res://items/Item.gd"

func use_on(player):
	GameState.player_swapped()
