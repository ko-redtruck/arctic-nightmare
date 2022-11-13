extends CanvasLayer

func _ready():
	if GameState.isSleeping:
		$RealityLabel.hide()
	else:
		$SleepLabel.hide()

func _on_Timer_timeout():
	get_tree().change_scene("res://scenes/GameOver.tscn")
