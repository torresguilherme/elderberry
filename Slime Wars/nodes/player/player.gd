extends KinematicBody2D

# stats
var hp = 100
var speed = 350

# movement
var up = 0
var down = 0
var left = 0
var right = 0
var moving = false
enum direct{UP, DOWN, LEFT, RIGHT}
var cur_direct = direct.DOWN

# onready nodes
onready var anim = get_node("anim")

func _ready():
	add_to_group(global.PLAYER_GROUP)
	set_process(true)
	pass

func _process(delta):
	# movement
	if Input.is_action_pressed("move-left"):
		left = 1
		cur_direct = direct.LEFT
	else:
		left = 0
	if Input.is_action_pressed("move-right"):
		right = 1
		cur_direct = direct.RIGHT
	else:
		right = 0
	if Input.is_action_pressed("move-up"):
		up = 1
		cur_direct = direct.UP
	else:
		up = 0
	if Input.is_action_pressed("move-down"):
		down = 1
		cur_direct = direct.DOWN
	else:
		down = 0
	
	# position update
	move(Vector2(-left+right, 0) * speed * delta)
	move(Vector2(0, -up+down) * speed * delta)
	if (-left+right == 0) && (-up+down == 0):
		moving = false
	else:
		moving = true
	
	# animation update
	if moving == false:
		if cur_direct == direct.UP:
			if anim.get_current_animation() != "up-idle":
				anim.set_current_animation("up-idle")
		elif cur_direct == direct.DOWN:
			if anim.get_current_animation() != "down-idle":
				anim.set_current_animation("down-idle")
		elif cur_direct == direct.LEFT:
			if anim.get_current_animation() != "left-idle":
				anim.set_current_animation("left-idle")
		elif cur_direct == direct.RIGHT:
			if anim.get_current_animation() != "right-idle":
				anim.set_current_animation("right-idle")
	else:
		if cur_direct == direct.UP:
			if anim.get_current_animation() != "up-walk":
				anim.set_current_animation("up-walk")
		elif cur_direct == direct.DOWN:
			if anim.get_current_animation() != "down-walk":
				anim.set_current_animation("down-walk")
		elif cur_direct == direct.LEFT:
			if anim.get_current_animation() != "left-walk":
				anim.set_current_animation("left-walk")
		elif cur_direct == direct.RIGHT:
			if anim.get_current_animation() != "right-walk":
				anim.set_current_animation("right-walk")

func TakeDamage(value):
	hp -= value