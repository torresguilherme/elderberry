extends Node2D

var level_dimension = 20
var number_of_rooms = 10
var level_matrix = []

var rooms = []
var door = preload("res://nodes/scenario/open-door.tscn")
var not_door = preload("res://nodes/scenario/wall2.tscn")

func _ready():
	randomize()
	rooms.append(load("res://nodes/rooms/room0.tscn"))
	generate_rooms()

func generate_rooms():
	var room_list = []
	for i in range(level_dimension):
		var new = []
		for j in range(level_dimension):
			new.append(0)
		level_matrix.append(new)
	var pos = [level_dimension/2, level_dimension/2]
	var rooms_left = number_of_rooms
	var modifiers = [-1, 1]
	while(rooms_left):
		if level_matrix[pos[0]][pos[1]] == 0:
			level_matrix[pos[0]][pos[1]] = 1
			rooms_left -= 1
			var new_room = rooms[randi()% rooms.size()].instance()
			new_room.set_global_pos(Vector2(pos[0] * global.ROOM_WIDTH, pos[1] * global.ROOM_HEIGHT))
			add_child(new_room)
			room_list.append(new_room)
		pos[randi()%2] += (randi()%3) - 1
		print(pos[0], ' ', pos[1])
	for it in level_matrix:
		print(it)
	# adiciona portas
	for it in room_list:
		var it_positions = it.get_node("positions")
		var it_doors = it.get_node("doors")
		var it_walls = it.get_node("walls")
		if (it.get_global_pos().y != 0) && (level_matrix[it.get_global_pos().x/global.ROOM_WIDTH][it.get_global_pos().y/global.ROOM_HEIGHT - 1] == 1):
			var new_door = door.instance()
			new_door.set_global_pos(it_positions.get_children()[0].get_pos())
			it_doors.add_child(new_door)
			print(new_door.get_global_pos())
		else:
			var new = not_door.instance()
			new.set_global_pos(it_positions.get_children()[0].get_pos())
			it_walls.add_child(new)
		if (it.get_global_pos().x != (level_dimension-1) * global.ROOM_WIDTH) && (level_matrix[it.get_global_pos().x/global.ROOM_WIDTH + 1][it.get_global_pos().y/global.ROOM_HEIGHT] == 1):
			var new_door = door.instance()
			new_door.set_global_pos(it_positions.get_children()[1].get_pos())
			new_door.set_rot(deg2rad(90))
			it_doors.add_child(new_door)
		else:
			var new = not_door.instance()
			new.set_global_pos(it_positions.get_children()[1].get_pos())
			it_walls.add_child(new)
		if (it.get_global_pos().y != (level_dimension-1) * global.ROOM_HEIGHT) && (level_matrix[it.get_global_pos().x/global.ROOM_WIDTH][it.get_global_pos().y/global.ROOM_HEIGHT + 1] == 1):
			var new_door = door.instance()
			new_door.set_global_pos(it_positions.get_children()[2].get_pos())
			new_door.set_rot(deg2rad(180))
			it_doors.add_child(new_door)
		else:
			var new = not_door.instance()
			new.set_global_pos(it_positions.get_children()[2].get_pos())
			it_walls.add_child(new)
		if (it.get_global_pos().x != 0) && (level_matrix[it.get_global_pos().x/global.ROOM_WIDTH - 1][it.get_global_pos().y/global.ROOM_HEIGHT] == 1):
			var new_door = door.instance()
			new_door.set_global_pos(it_positions.get_children()[3].get_pos())
			new_door.set_rot(deg2rad(270))
			it_doors.add_child(new_door)
		else:
			var new = not_door.instance()
			new.set_global_pos(it_positions.get_children()[3].get_pos())
			it_walls.add_child(new)