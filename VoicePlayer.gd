extends Node


var voice_dict = {
	"dream_teasing_1": preload("res://assets/sounds/voice/dreamteasing_part1.mp3"),
	"dream_teasing_2": preload("res://assets/sounds/voice/dreamteasing_part2.mp3"),
	"dream_teasing_3": preload("res://assets/sounds/voice/dreamteasing_part3.mp3"),
	"dream_teasing_4": preload("res://assets/sounds/voice/dreamteasing_part4.mp3"),
	"dream_teasing_5": preload("res://assets/sounds/voice/dreamteasing_part5.mp3"),
	"electricity_1": preload("res://assets/sounds/voice/electricity_part1.mp3"),
	"electricity_2": preload("res://assets/sounds/voice/electricity_part2.mp3"),
	"fork_1": preload("res://assets/sounds/voice/fork_part1.mp3"),
	"fork_2": preload("res://assets/sounds/voice/fork_part2.mp3"),
	"gravity_1": preload("res://assets/sounds/voice/gravity_part1.mp3"),
	"gravity_2": preload("res://assets/sounds/voice/intro_part1.mp3"),
	"intro_1": preload("res://assets/sounds/voice/intro_part1.mp3"),
	"intro_2": preload("res://assets/sounds/voice/intro_part2.mp3"),
	"knife_1": preload("res://assets/sounds/voice/knife_part1.mp3"),
	"knife_2": preload("res://assets/sounds/voice/knife_part2.mp3"),
	"lego_1": preload("res://assets/sounds/voice/Lego_part1.mp3"),
	"lego_2": preload("res://assets/sounds/voice/Lego_part2.mp3"),
	"microwave_1": preload("res://assets/sounds/voice/microwave_part1.mp3"),
	"microwave_2": preload("res://assets/sounds/voice/microwave_part2.mp3"),
	"pineapple_1": preload("res://assets/sounds/voice/pp_part1.mp3"),
	"pineapple_2": preload("res://assets/sounds/voice/pp_part2.mp3"),
	"random_debris_1": preload("res://assets/sounds/voice/randomdebris_part1.mp3"),
	"random_debris_2": preload("res://assets/sounds/voice/randomdebris_part2.mp3"),
	"ratpoison_1": preload("res://assets/sounds/voice/ratpoison_part1.mp3"),
	"ratpoison_2": preload("res://assets/sounds/voice/ratpoison_part2.mp3"),
	"secret_ending_hint_1": preload("res://assets/sounds/voice/secret_ending_hint_part1.mp3"),
	"secret_ending_hint_2": preload("res://assets/sounds/voice/secret_ending_hint_part2.mp3"),
	"secret_ending_hint_3": preload("res://assets/sounds/voice/secret_ending_hint_part3.mp3"),
	"secret_ending_hint_4": preload("res://assets/sounds/voice/secret_ending_hint_part4.mp3"),
	"immolation_1": preload("res://assets/sounds/voice/self_immolation_part1.mp3"),
	"immolation_2": preload("res://assets/sounds/voice/self_immolation_part2.mp3"),
	"toaster_1": preload("res://assets/sounds/voice/toaster_part1.mp3"),
	"toaster_2": preload("res://assets/sounds/voice/toaster_part2.mp3"),
	"tutorial_1": preload("res://assets/sounds/voice/tutorial_part1.mp3"),
	"tutorial_2": preload("res://assets/sounds/voice/tutorial_part2.mp3"),
	"tutorial_3": preload("res://assets/sounds/voice/tutorial_part3.mp3"),
	"tutorial_4": preload("res://assets/sounds/voice/tutorial_part4.mp3"),
	"swapper_1": preload("res://assets/sounds/voice/swapper_part1.mp3"),
	"swapper_2": preload("res://assets/sounds/voice/swapper_part2.mp3"),
	"wilson_1": preload("res://assets/sounds/voice/wilson_part1.mp3"),
	"wilson_2": preload("res://assets/sounds/voice/wilson_part2.mp3"),
	"propeller_1": preload("res://assets/sounds/voice/popeller_part1.mp3"),
	"propeller_2": preload("res://assets/sounds/voice/popeller_part2.mp3"),
	}


	
func play_voice(voiceline: String):
	print()
	$AudioStreamPlayer.stream = voice_dict[voiceline]
	$AudioStreamPlayer.play()
		
	
func _ready():
	pass # Replace with function body.
