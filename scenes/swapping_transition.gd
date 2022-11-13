extends Node2D

func _ready():
	if GameState.isSleeping:
		$Label.text = "You awake by shock after dying in your dreams and quickly escape into a parallel universe..."
	else:
		$Label.text = "You activate the swapping device and esscape into a parallel universe..."

func _on_Timer_timeout():
	get_tree().change_scene("res://scenes/Game.tscn")
