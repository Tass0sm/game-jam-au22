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
	$Player.set_camera_limits(map_limits, map_cellsize)
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass
