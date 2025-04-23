extends CharacterBody2D

@export var speed : float
var base_speed = 200
@export var jump_speed : float
var run_speed = 300
var gravity = ProjectSettings.get_setting("physics/2d/default_gravity")
var climb_speed = -100
var is_on_wall = false
var wall_direction = 0

func is_on_wall_left():
	return test_move(transform, Vector2(-1, 0))

func is_on_wall_right():
	return test_move(transform, Vector2(1, 0))


func get_inptu(delta):
	var input_axis = Input.get_axis("move_left","move_right")
	velocity.x = input_axis * speed
	
	if Input.is_action_just_pressed("jump") and is_on_floor():
		velocity.y = -jump_speed
	
	if not is_on_floor():
		velocity.y += gravity * delta
	
	
	if Input.is_action_pressed("run"):
		speed += run_speed * delta 
	else:
		speed = base_speed
	
	is_on_wall = false
	wall_direction = 0
	
	if is_on_wall_left():
		is_on_wall = true
		wall_direction = -1
	if is_on_wall_right():
		is_on_wall = true
		wall_direction = 1
	
	if is_on_wall and Input.is_action_pressed("climb"):
		velocity.y = climb_speed

func _physics_process(delta):
	
	get_inptu(delta)
	move_and_slide()
	
	
