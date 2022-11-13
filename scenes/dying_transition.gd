extends Node2D

func _ready():
	if GameState.isSleeping:
		$Label.text = "You activate the swapping device while still sleeping and die in the real world..."
	else:
		$Label.text = "You just killed yourself in the real world..."

func _on_Timer_timeout():
	get_tree().change_scene("res://scenes/GameOver.tscn")
