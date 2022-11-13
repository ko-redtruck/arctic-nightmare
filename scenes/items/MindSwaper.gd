extends "res://scenes/items/Item.gd"

var swapper_texture = preload("res://assets/characters/scientist_animation_mindswapper.png")
var normal_texture = preload("res://assets/characters/scientist_animation.png")

onready var MINDSWAP_SOUND = preload("res://assets/sounds/mindswapper.mp3")

func use_on(player):
	.use_on(player)
	GameState.player_swapped()

func pick_up_on(player):
	.pick_up_on(player)
	player.get_node("Sprite").set_texture(swapper_texture)
	$Sprite.hide()

func on_drop(player):
	.on_drop(player)
	player.get_node("Sprite").set_texture(normal_texture)
	$Sprite.show()

func _ready():
	self.voice_lines =  ["swapper_1", "swapper_2"]
	self.sound_effect = MINDSWAP_SOUND
