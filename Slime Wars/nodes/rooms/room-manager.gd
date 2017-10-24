extends Node2D

onready var camera = get_node("Camera2D")
onready var player = get_node("../").get_node("player")
onready var doors = get_node("doors")
onready var enemies = get_node("enemies")

func _ready():
	set_process(true)

func _process(delta):
	if abs((get_global_pos() - player.get_global_pos()).x) < global.ROOM_WIDTH/2 - 50 && abs((get_global_pos() - player.get_global_pos()).y) < global.ROOM_HEIGHT/2 - 50:
		camera.make_current()