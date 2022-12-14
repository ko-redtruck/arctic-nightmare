extends "res://scenes/items/Item.gd"

var group = "Bathtub"
onready var ELECTROCUTE_SOUND = preload("res://assets/sounds/electrocute.mp3")

func is_usable():
	return is_in_effect_range(group)

func use_on(player):
	var bathtub = get_in_effect_range(group)
	if bathtub != null:
		player.play_sound_effect(ELECTROCUTE_SOUND)
		var lightning = preload("res://scenes/props/Lightning.tscn").instance()
		lightning.targets.append(player)
		lightning.targets.append(bathtub)
		get_node("/root/Game").add_child(lightning)
		player.current_idle_animation = "electrocute"
		yield(get_tree().create_timer(1.5), "timeout")
		player.kill()

func _ready():
	self.voice_lines =  ["toaster_1", "toaster_1"]
