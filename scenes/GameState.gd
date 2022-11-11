extends Node

var isSleeping: bool

func _ready():
	print("helo")

func start_level():
	isSleeping = randi() % 2 == 0
