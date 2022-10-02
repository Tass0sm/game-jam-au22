extends Node2D


# Declare member variables here. Examples:
# var a = 2
# var b = "text"

var map_limits
var map_cellsize

# Called when the node enters the scene tree for the first time.
func _ready():
	map_limits = $TileMap.get_used_rect()
	map_cellsize = $TileMap.cell_size
	$Player/Camera.limit_left = map_limits.position.x * map_cellsize.x
	$Player/Camera.limit_right = map_limits.end.x * map_cellsize.x
	$Player/Camera.limit_top = map_limits.position.y * map_cellsize.y
	$Player/Camera.limit_bottom = map_limits.end.y * map_cellsize.y
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass
