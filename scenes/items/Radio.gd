extends "res://scenes/items/Item.gd"

var party = preload("res://assets/sounds/PartyNeverStops.mp3")
var flute = preload("res://assets/sounds/heknowswhenyousleep.wav")

func is_usable():
	return true

func use_on(player):
	$AudioStreamPlayer2D.playing = not $AudioStreamPlayer2D.playing
	
func _ready():
	self.item_name = "radio"
	if GameState.isSleeping:
		$AudioStreamPlayer2D.stream = party
	else:
		$AudioStreamPlayer2D.stream = flute
