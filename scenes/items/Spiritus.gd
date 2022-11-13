extends "res://scenes/items/Item.gd"
var fire = preload("res://assets/particles/fire.tscn")
var fire_instance = fire.instance()

func use_on(player):
	$Sprite.hide()
	player.add_child(fire_instance)
	player.current_idle_animation = "burn"
	yield(get_tree().create_timer(1.0), "timeout")
	player.kill()
	

func is_usable():
	return true

func _ready():
	self.voice_lines =  ["immolation_1", "immolation_2"]
