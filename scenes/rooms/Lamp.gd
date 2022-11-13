extends Node2D


export (float) var MAX_ROTATION
export (float) var ROTATION_SPEED

var phase = 0
var rotation_direction = 1
# Called when the node enters the scene tree for the first time.
func _ready():
	randomize()
	self.phase = rand_range(0, 2 * PI)
	if GameState.is_in_random_sleep_state():
		MAX_ROTATION = rand_range(0, 2 * PI)



func _process(delta):
	phase += delta * ROTATION_SPEED
	self.rotation = sin(phase) * MAX_ROTATION
