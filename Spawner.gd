extends Node2D


# Declare member variables here. Examples:
# var a = 2
# var b = "text"

var enemy = preload("res://EnemyScene.tscn")

func init(p):
	position = p

func spawn():
	var e = enemy.instance()
	add_child(e)
	randomize()
	var x_comp = rand_range(-10, 10)
	e.apply_central_impulse(Vector2(x_comp, -20))

func spawn_wave(count):
	for i in range(count):
		spawn()
		$SingleEnemyTimer.start()
		yield($SingleEnemyTimer, "timeout")

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass
