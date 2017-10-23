extends Node2D

onready var camera = get_node("Camera2D")
onready var player = get_node("../").get_node("player")
var ROOM_WIDTH = 1408
var ROOM_HEIGHT = 1024

func _ready():
	set_process(true)

func _process(delta):
	if abs((get_global_pos() - player.get_global_pos()).x) < ROOM_WIDTH/2 && abs((get_global_pos() - player.get_global_pos()).y) < ROOM_HEIGHT/2:
		camera.make_current()
	else:
		camera.clear_current()