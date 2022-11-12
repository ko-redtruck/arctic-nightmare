extends Node2D

export var room_size = Vector2(9, 6)
export var wall_thickness = .5

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
	# var position = -room_size
	var i = 0
	for room in rooms:
		var position = index_to_vec(i)
		
		var instance = room.instance()
		instance.position = position
		add_child(instance)
		i+=1
		
		#position.x += room_size.x + wall_thickness
		#if position.x > room_size.x:
		#	position.x = -room_size.x
		#	position.y += room_size.y + wall_thickness
			
	# place doors procedurally
	var room_connections = dfs()
	# print(room_connections)
	for connection in room_connections:
		var v1 = index_to_vec(connection[0])
		var v2 = index_to_vec(connection[1])
		var wall_center = (v1 + v2)/2
		
		var is_horizontal = abs(connection[0] - connection[1]) == 1
		
		var wall
		if !is_horizontal:
			wall = load('res://scenes/HorizontalWallWithDoor.tscn').instance()
		else:
			wall = load('res://scenes/VerticalWallWithDoor.tscn').instance()
		
		wall.position = wall_center
		wall.set_name("WallWithDoor" + str(connection[0], "-", connection[1]))
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
		var selected_room = up_next_list.pop_front()
		
		var neighbours = neighbours_in_bounds(selected_room)
		var add_next = []
		
		# filter already done
		for neighbour in neighbours:
			if !(done_list.has(neighbour) or up_next_list.has(neighbour)):
				add_next.push_back(neighbour)
				
		# add edges
		for node in add_next:
			edge_list.push_back([selected_room, node])
		
		up_next_list.append_array(add_next)
		
		done_list.push_back(selected_room)
	
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
	return Vector2((index % 3) - 0.5, int(index / 3) - 0.5) * (Vector2(9, 6) + Vector2(wall_thickness, wall_thickness)) - Vector2(4.5, 3)
