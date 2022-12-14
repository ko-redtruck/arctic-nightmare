extends "res://scenes/items/Item.gd"
var blood = preload("res://assets/particles/blood.tscn")
var blood_instance = blood.instance()
onready var STAB_SOUND = preload("res://assets/sounds/stab.mp3")

func use_on(player):
	.use_on(player)
	$Sprite.hide()
	player.add_child(blood_instance)
	player.current_idle_animation = "stab"
	yield(get_tree().create_timer(1.0), "timeout")
	player.kill()
	

func is_usable():
	return true

func _ready():
	self.voice_lines =  ["knife_1", "knife_2"]
	self.sound_effect = STAB_SOUND

