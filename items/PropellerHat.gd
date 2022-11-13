extends "res://items/Item.gd"

export (bool) var CAN_FLY = true


export (float) var FLY_FORCE = 20.0
var cooldown_over = true

func use_on(player):
	if self.is_usable():
		player.velocity.y -= FLY_FORCE
		$CooldownTimer.start()
		cooldown_over = false

func is_usable():
	return cooldown_over and self.CAN_FLY
func _on_CooldownTimer_timeout():
	cooldown_over = true
	
