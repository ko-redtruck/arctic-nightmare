extends Node

var items = [
	preload("res://scenes/items/Knife.tscn"),
	preload("res://scenes/items/MindSwaper.tscn"),
	preload("res://scenes/items/PropellerHat.tscn"),
	preload("res://scenes/items/Toaster.tscn"),
]

onready var _anim_player := $SceneTransitionRect/AnimationPlayer

func _ready():
	self.start_level()

func start_level():
	var effects = Effects.all
	get_node("AudioStreamPlayer").play()
	$StormCountdown.wait_time = GameState.time_until_snow_storm
	$StormCountdown.start()
	spawn_items()

func stop_level():
	$StormCountdown.pause()
	
func _on_Timer_timeout():
	GameState.player_killed()

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
