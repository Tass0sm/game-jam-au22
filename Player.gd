extends KinematicBody2D

# Declare member variables here. Examples:
# var a = 2
# var b = "text"

export var speed = 600 # How fast the player will move (pixels/sec).
var velocity
var mouse_position

var max_vision_angle = PI / 6
var max_distance = 400
var push_pull_strength = 20

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.

func set_camera_limits(map_limits, map_cellsize):
	$Camera.limit_left = map_limits.position.x * map_cellsize.x
	$Camera.limit_right = map_limits.end.x * map_cellsize.x
	$Camera.limit_top = map_limits.position.y * map_cellsize.y
	$Camera.limit_bottom = map_limits.end.y * map_cellsize.y

func is_enemy_visible(enemy):
	var player_to_mouse = position.direction_to(get_global_mouse_position())
	var player_to_enemy = position.direction_to(enemy.position)
	var distance_to_enemy = player_to_enemy.length()
	var angle_to_enemy = player_to_enemy.angle_to(player_to_mouse)
	return distance_to_enemy < max_distance && abs(angle_to_enemy) < max_vision_angle

func push_enemy(enemy):
	var player_to_enemy = (enemy.position - position).normalized()
	enemy.apply_central_impulse(player_to_enemy * push_pull_strength)
	
func pull_enemy(enemy):
	var player_to_enemy = (enemy.position - position).normalized()
	enemy.apply_central_impulse(player_to_enemy * -push_pull_strength)

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	# Look at mouse
	rotation = get_global_mouse_position().angle_to_point(position)
	
	# check all enemies and see if they are visible
	var visible_enemy_count = 0
	
	for body in $FrontArea.get_overlapping_bodies():
		if body.is_in_group("enemies"):
			if Input.is_action_pressed("mouse_left"):
				push_enemy(body)
			if Input.is_action_pressed("mouse_right"):
				pull_enemy(body)
			
			#var player_to_mouse = position.direction_to(get_global_mouse_position())
			#var player_to_enemy = position.direction_to(enemy.position)
			visible_enemy_count += 1
				
	print(visible_enemy_count)
	pass
	
func _physics_process(delta):
	velocity = Vector2.ZERO
	if Input.is_action_pressed("move_right"):
		velocity.x += 1
	if Input.is_action_pressed("move_left"):
		velocity.x -= 1
	if Input.is_action_pressed("move_down"):
		velocity.y += 1
	if Input.is_action_pressed("move_up"):
		velocity.y -= 1
	
	if velocity.length() > 0:
		velocity = velocity.normalized() * speed

	velocity = move_and_slide(velocity)
