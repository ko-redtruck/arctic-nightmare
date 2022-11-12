extends Node2D

func _ready():
	if GameState.isSleeping:
		$Label.text = "You activate the swapping device while still sleeping and die in the real world..."
	else:
		$Label.text = "You just killed yourself in the real world..."

func _on_Timer_timeout():
	GameState.reset()
	get_tree().change_scene("res://scenes/Game.tscn")
