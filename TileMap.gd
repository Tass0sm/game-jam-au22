extends TileMap


# Declare member variables here. Examples:
# var a = 2
# var b = "text"

var spawner_tile_id = 1
var spawner = preload("res://Spawner.tscn")

# Called when the node enters the scene tree for the first time.
func _ready():
	var spawner_cells = get_used_cells_by_id(spawner_tile_id)
	for cell in spawner_cells:
		var cell_location = map_to_world(cell)
		var s = spawner.instance()
		s.init(cell_location)
		add_child(s)
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	
	pass
