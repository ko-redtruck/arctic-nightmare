extends StaticBody2D

export (int) var MAX_WATER_TIMER = 20

# Called when the node enters the scene tree for the first time.
func _ready():
	randomize()
	$WaterTimer.wait_time = rand_range(2, MAX_WATER_TIMER)
	if not GameState.is_in_random_sleep_state():
		$WaterTimer.start()
	


# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass


func _on_WaterTimer_timeout():
	$WaterParticles2D.emitting = false
