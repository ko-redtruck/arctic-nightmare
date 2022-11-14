extends Node

var isSleeping: bool

var iteration

var time_until_snow_storm

var death_count = 0
export (int) var MIN_ITERATION_FOR_WIN = 5

func _ready():
	randomize()
	reset()

func is_in_random_sleep_state():
  randomize()
  return self.isSleeping and rand_range(0, 1.0) <= pow(2.718281828,-(self.iteration - 1)/ 7)

func reset():
	iteration = 0
	time_until_snow_storm = 40

func start_next_level():
	isSleeping = randi() % 2 == 0
	time_until_snow_storm += 20
	iteration += 1
	print("Is Sleeping start next level", isSleeping)
	get_tree().change_scene("res://scenes/Game.tscn")

func play_voice(voice_line):
	get_node("/root/Game/VoicePlayer").play_voice(voice_line)
	
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

func player_is_inactive():
	if self.iteration > MIN_ITERATION_FOR_WIN:
		get_tree().change_scene("res://scenes/WinScreen.tscn")
