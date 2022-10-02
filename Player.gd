extends Area2D

# Declare member variables here. Examples:
# var a = 2
# var b = "text"

export var speed = 400 # How fast the player will move (pixels/sec).
var mouse_position
var screen_size

var max_vision_angle = PI / 3
var max_distance = 400
var push_pull_strength = 10

# Called when the node enters the scene tree for the first time.
func _ready():
	screen_size = get_viewport_rect().size
	pass # Replace with function body.

func is_enemy_visible(enemy):
	var player_to_mouse = position.direction_to(get_global_mouse_position())
	var player_to_enemy = position.direction_to(enemy.position)
	var distance_to_enemy = player_to_enemy.length()
	var angle_to_enemy = player_to_enemy.angle_to(player_to_mouse)
	print(distance_to_enemy)
	return distance_to_enemy < max_distance && abs(angle_to_enemy) < max_vision_angle

func push_enemy(enemy):
	var player_to_enemy = position.direction_to(enemy.position)
	enemy.apply_central_impulse(player_to_enemy * push_pull_strength)
	
func pull_enemy(enemy):
	var player_to_enemy = position.direction_to(enemy.position)
	enemy.apply_central_impulse(player_to_enemy * -push_pull_strength)

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):	
	var velocity = Vector2.ZERO # The player's movement vector.
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
		
	position += velocity * delta
	position.x = clamp(position.x, 0, screen_size.x)
	position.y = clamp(position.y, 0, screen_size.y)

	# Look at mouse
	rotation = get_global_mouse_position().angle_to_point(position)
	
	# check all enemies and see if they are visible
	for enemy in get_tree().get_nodes_in_group("enemies"):
		if is_enemy_visible(enemy):
			if Input.is_action_pressed("mouse_left"):
				push_enemy(enemy)
			if Input.is_action_pressed("mouse_right"):
				pull_enemy(enemy)
			

	pass
