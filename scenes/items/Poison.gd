extends "res://scenes/items/Item.gd"

onready var POISON_SOUND = preload("res://assets/sounds/poison.mp3")
func use_on(player):
	$Sprite.hide()
	player.current_idle_animation = "lego"
	yield(get_tree().create_timer(1.5), "timeout")
	player.kill()

func is_usable():
	return true

func _ready():
	self.voice_lines =  ["ratpoison_1", "ratpoison_2"]
	self.sound_effect = POISON_SOUND
