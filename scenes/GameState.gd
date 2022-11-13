extends Node

var isSleeping: bool

var iteration

var time_until_snow_storm

func _ready():
	reset()

func reset():
	iteration = 0
	time_until_snow_storm = 60

func start_level():
	randomize()
	iteration += 1
	time_until_snow_storm *= 0.95
	isSleeping = randi() % 2 == 0
	print(isSleeping)
	get_node("/root/Game").start_level()

func player_killed():
	if isSleeping:
		transition_to("res://scenes/swapping_transition.tscn")
		#get_tree().change_scene("res://scenes/swapping_transition.tscn")
	else:
		transition_to("res://scenes/dying_transition.tscn")
		#get_tree().change_scene("res://scenes/dying_transition.tscn")

func player_swapped():
	if isSleeping:
		"res://scenes/dying_transition.tscn"
		#get_tree().change_scene("res://scenes/dying_transition.tscn")
	else:
		#get_tree().change_scene("res://scenes/swapping_transition.tscn")
		transition_to("res://scenes/swapping_transition.tscn")
		
func transition_to(nextScene):
	get_tree().change_scene(nextScene)
