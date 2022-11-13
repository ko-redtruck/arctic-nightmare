extends "res://scenes/items/Item.gd"


func pick_up_on(player):
	.pick_up_on(player)
	randomize()
	var randint = randi() % 8
	print("Random pickup", randint)
	if randint == 0:
		GameState.play_voice("knife_1")
	elif randint == 1:
		GameState.play_voice("knife_2")
	
func use_on(player):
	player.kill()

func is_usable():
	return true

func _ready():
	pass
