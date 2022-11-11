extends Node2D

export var room_size = Vector2(9, 6)

var rooms = [
	preload("res://scenes/rooms/Kitchen.tscn"),
	preload("res://scenes/rooms/Bathroom.tscn"),
	preload("res://scenes/rooms/Lab.tscn"),
	preload("res://scenes/rooms/Bedroom.tscn"),
	preload("res://scenes/rooms/Storage.tscn"),
	preload("res://scenes/rooms/Garage.tscn"),
	preload("res://scenes/rooms/Medbay.tscn"),
	preload("res://scenes/rooms/Greenhouse.tscn"),
	preload("res://scenes/rooms/CoWorkingSpace.tscn"),
]

func _ready():
	init_rooms()

func init_rooms():
	# shuffle
	randomize()
	rooms.shuffle()
	
	# instanciated_rooms = []
	var position = -room_size
	for room in rooms:
		var instance = room.instance()
		instance.position = position
		add_child(instance)
		
		position.x += room_size.x
		if position.x > room_size.x:
			position.x = -room_size.x
			position.y += room_size.y
			
func dfs():
	var edge_list = []
	
	var start_room = randi() % 9
	
	print("TODO")
	
	
	
	return edge_list
