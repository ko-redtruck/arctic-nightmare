extends "res://scenes/items/Item.gd"

onready var LEGO_SOUND_EFFECT = preload("res://assets/sounds/lego.mp3")

func use_on(player):
	.use_on(player)
	$Sprite.hide()
	player.current_idle_animation = "lego"
	yield(get_tree().create_timer(1.5), "timeout")
	player.kill()

func is_usable():
	return true

func _ready():
	self.voice_lines =  ["lego_1", "lego_2"]
	self.sound_effect = LEGO_SOUND_EFFECT
