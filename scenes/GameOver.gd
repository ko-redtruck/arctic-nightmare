extends Node2D


func play_again():
	GameState.reset()
	GameState.start_next_level()


func _on_PlayAgainButton_pressed():
	self.play_again()

func _on_PlayIntroButton_pressed():
	$VoicePlayer.play_voice("intro_1")


func _on_Death_count_ready():
	$Death_count.text = "Death count: " + str(GameState.death_count)

