extends Node2D

export var room_size = Vector2(9, 6)
export var wall_thickness = .125

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

var wall_connectors = [
	preload("res://scenes/wall_connectors/door.tscn"),
]
var ceiling_connectors = [
	preload("res://scenes/ceiling_connectors/ladderLeft.tscn")
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
	for i1 in range(len(rooms)):
		for i2 in range(i1):
			if not (i2 in neighbours_in_bounds(i1)):
				continue
			
			var v1 = index_to_vec(i1)
			var v2 = index_to_vec(i2)
			var connection_center = (v1 + v2)/2
			var connection_instance = null
			if is_connected(room_connections, i1, i2):
				if v1.y == v2.y:
					var index = randi() % len(wall_connectors)
					connection_instance = wall_connectors[index].instance()
				else:
					var index = randi() % len(ceiling_connectors)
					connection_instance = ceiling_connectors[index].instance()
			else:
				if v1.y == v2.y:
					connection_instance = preload("res://scenes/wall_connectors/wall.tscn").instance()
				else:
					connection_instance = preload("res://scenes/ceiling_connectors/ceiling.tscn") .instance()
			connection_instance.position = connection_center
			connection_instance.set_name("RoomConnector" + str(i1, "-", i2))
			# print(connection)
			# print(v1)
			# print(v2)
			# print(wall_center)

			add_child(connection_instance)

func is_connected(connections, i1, i2):
	for connection in connections:
		if i1 == connection[0] and i2 == connection[1] or i2 == connection[0] and i1 == connection[1]:
			return true
	return false

func dfs():
	var edge_list = []

	randomize()
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

	print(edge_list)
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
