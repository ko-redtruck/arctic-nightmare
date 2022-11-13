extends Node


onready var _anim_player := $SceneTransitionRect/AnimationPlayer

func _ready():
	self.start_level()

func start_level():
	var effects = Effects.all
	get_node("AudioStreamPlayer").play()
	$StormCountdown.wait_time = GameState.time_until_snow_storm
	$StormCountdown.start()

func stop_level():
	$StormCountdown.pause()
	
func _on_Timer_timeout():
	GameState.player_killed()

func _process(delta):
	GameState.time_until_snow_storm = $StormCountdown.time_left
