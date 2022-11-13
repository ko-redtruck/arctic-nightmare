extends "res://items/Item.gd"

export (bool) var can_fly = true


export (float) var FLY_FORCE = 20.0
var cooldown_over = true

func use_on(player):
	if cooldown_over:
		player.velocity.y -= FLY_FORCE
		$CooldownTimer.start()
		cooldown_over = false


func _on_CooldownTimer_timeout():
	cooldown_over = true
	
