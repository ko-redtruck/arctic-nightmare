extends "res://scenes/items/Item.gd"
var blood = preload("res://assets/particles/blood.tscn")
var blood_instance = blood.instance()


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
	$Sprite.hide()
	player.add_child(blood_instance)
	player.current_idle_animation = "stab"
	yield(get_tree().create_timer(1.0), "timeout")
	player.kill()
	

func is_usable():
	return true

func _ready():
	pass
