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
			
	# place doors procedurally
	var room_connections = dfs()
	# print(room_connections)
	for connection in room_connections:
		var v1 = index_to_vec(connection[0])
		var v2 = index_to_vec(connection[1])
		var wall_center = (v1 + v2)/2
		var wall = load('res://scenes/TempWallConnector.tscn').instance()
		wall.position = wall_center
		wall.set_name("WallConnector" + str(connection[0], connection[1]))
		# print(connection)
		# print(v1)
		# print(v2)
		# print(wall_center)
		
		add_child(wall)
	
func dfs():
	var edge_list = []
	
	var start_room = randi() % 9
	
	var done_list = []
	var up_next_list = [start_room]
	
	while done_list.size() < 9:
		# print(up_next_list)
		# print(done_list)
		
		up_next_list.shuffle()
		var t = up_next_list.pop_front()
		
		var add_next = neighbours_in_bounds(t)
		
		# filter already done
		for i in add_next:
			if done_list.has(i) or up_next_list.has(i):
				add_next.erase(i)
				
		# add edges
		for i in add_next:
			edge_list.push_back([t, i])
		
		up_next_list.append_array(add_next)
		
		done_list.push_back(t)
	
	print("TODO")
	
	return edge_list
	
func neighbours_in_bounds(index):
	var neighbours = []
	if index % 3 != 0:
		neighbours.push_back(index - 1)
		
	if index % 3 != 2:
		neighbours.push_back(index + 1)
		
	if int(index / 3) != 0:
		neighbours.push_back(index - 3)
		
	if int(index / 3) != 2:
		neighbours.push_back(index + 3)
		
	return neighbours

func index_to_vec(index):
	return Vector2((index % 3) - 0.5, int(index / 3) - 0.5) * Vector2(9, 6) - Vector2(4.5, 3)
