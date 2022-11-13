extends Node2D


func play_again():
	GameState.reset()
	GameState.start_next_level()


func _on_PlayAgainButton_pressed():
	self.play_again()
