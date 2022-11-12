extends Node2D

func _ready():
	if GameState.isSleeping:
		$Label.text = "You awake by shock of dying while dreaming and quickly swap into a parallel universe..."
	else:
		$Label.text = "You activate the swapping device and swap into a parallel universe..."

func _on_Timer_timeout():
	get_tree().change_scene("res://scenes/Game.tscn")
