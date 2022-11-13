extends Node

var items = [
	preload("res://scenes/items/Knife.tscn"),
	preload("res://scenes/items/MindSwaper.tscn"),
	preload("res://scenes/items/PropellerHat.tscn"),
	preload("res://scenes/items/Toaster.tscn"),
	preload("res://scenes/items/Fork.tscn"),
	preload("res://scenes/items/Radio.tscn"),
	preload("res://scenes/items/Can.tscn"),
	preload("res://scenes/items/Hawaii.tscn"),
	preload("res://scenes/items/Lego.tscn"),
	preload("res://scenes/items/Poison.tscn"),
	preload("res://scenes/items/Spiritus.tscn"),
	preload("res://scenes/items/Wilson.tscn"),
]

onready var _anim_player := $SceneTransitionRect/AnimationPlayer

func _ready():
	print("Starting new level")
	self.start_level()

func start_level():
	var effects = Effects.all
	get_node("AudioStreamPlayer").play()
	$StormCountdown.wait_time = GameState.time_until_snow_storm
	$StormCountdown.start()
	spawn_items()
	scripted_voice()
		

func stop_level():
	$StormCountdown.pause()
	
func _on_VoiceLineTimer_timeout():
	$VoicePlayer.play_voice("tutorial_4_3")
	

func _process(delta):
	GameState.time_until_snow_storm = $StormCountdown.time_left

func spawn_items():
	var spawns = get_tree().get_nodes_in_group("item_spawn")
	var items_left = len(items)
	print("isSleeping ", GameState.isSleeping)
	for item_scene in items:
		items_left -= 1
		var spawn_index = randi() % len(spawns)
		print(spawn_index)
		var spawn = spawns[spawn_index]
		spawns.remove(spawn_index)
		var item = item_scene.instance()
		item.global_position = spawn.global_position
		if GameState.is_in_random_sleep_state() or (items_left <= 0 and GameState.isSleeping):
			var effect = Effects.all[randi() % len(Effects.all)]
			print("applying ", effect, " to ", item)
			effect.apply(item)
		add_child(item)


func _on_StormCountdown_timeout():
	GameState.death_count = GameState.death_count + 1
	get_tree().change_scene("res://scenes/StormDeath.tscn")

func scripted_voice():
	if (GameState.death_count + GameState.iteration == 0):
		$VoiceLineTimer.wait_time = 30
		$VoiceLineTimer.start()
		$VoicePlayer.play_voice("tutorial_1_2")
	if (GameState.death_count + GameState.iteration == 5):
		$VoicePlayer.play_voice("secret_ending_hint_1")
	if (GameState.death_count + GameState.iteration == 10):
		$VoicePlayer.play_voice("secret_ending_hint_2")
	if (GameState.death_count + GameState.iteration == 13):
		$VoicePlayer.play_voice("secret_ending_hint_3")
	if (GameState.death_count + GameState.iteration == 15):
		$VoicePlayer.play_voice("secret_ending_hint_4")
