extends "res://scenes/items/Item.gd"
var puke = preload("res://assets/particles/puke.tscn")
var puke_instance = puke.instance()

func use_on(player):
	$Sprite.hide()
	player.add_child(puke_instance)
	player.current_idle_animation = "idle"
	yield(get_tree().create_timer(1.0), "timeout")
	player.kill()

func is_usable():
	return true

func _ready():
	self.voice_lines =  ["pineapple_1", "pineapple_2"]
