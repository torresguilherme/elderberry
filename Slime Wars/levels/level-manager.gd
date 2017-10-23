extends Node2D

var level_dimension = 20
var number_of_rooms = 10
var level_matrix = []

var rooms = []

func _ready():
	randomize()
	rooms.append(load("res://nodes/rooms/room0.tscn"))
	generate_rooms()

func generate_rooms():
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
		pos[randi()%2] += modifiers[randi() % modifiers.size()]
	