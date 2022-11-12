extends Node

func _ready():
	GameState.start_level()

func start_level():
	var effects = Effects.all

func _on_Timer_timeout():
	if $Player2D.position.x < 0:
		GameState.player_killed()
	else:
		GameState.player_swapped()
