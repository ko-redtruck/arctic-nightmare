extends CanvasLayer

func _ready():
	if GameState.isSleeping:
		$RealityLabel.hide()
	else:
		$SleepLabel.hide()

func _on_Timer_timeout():
	GameState.start_next_level()
