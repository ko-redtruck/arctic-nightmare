extends Node2D


func play_again():
	GameState.reset()
	get_tree().change_scene("res://scenes/Game.tscn")


func _on_PlayAgainButton_pressed():
	self.play_again()
