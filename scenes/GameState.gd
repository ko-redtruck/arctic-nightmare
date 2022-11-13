extends Node

var isSleeping: bool

var iteration

var time_until_snow_storm

var death_count = 0

func _ready():
	randomize()
	reset()

func is_in_random_sleep_state():
	#1/self.iteration +1 chance
	return self.isSleeping and rand_range(0, self.iteration - 1) == 0

func reset():
	iteration = 0
	time_until_snow_storm = 40

func start_next_level():
	isSleeping = randi() % 2 == 0
	time_until_snow_storm += 20
	iteration += 1
	print("Is Sleeping", isSleeping)
	get_tree().change_scene("res://scenes/Game.tscn")

func player_killed():
	if isSleeping:
		transition_to("res://scenes/swapping_transition.tscn")
		#get_tree().change_scene("res://scenes/swapping_transition.tscn")
	else:
		transition_to("res://scenes/dying_transition.tscn")
		#get_tree().change_scene("res://scenes/dying_transition.tscn")

func player_swapped():
	if isSleeping:
		transition_to("res://scenes/dying_transition.tscn")
		#get_tree().change_scene("res://scenes/dying_transition.tscn")
	else:
		#get_tree().change_scene("res://scenes/swapping_transition.tscn")
		transition_to("res://scenes/swapping_transition.tscn")
		
func transition_to(nextScene):
	if (nextScene == "res://scenes/dying_transition.tscn"):
		death_count=death_count+1
	get_tree().change_scene(nextScene)
