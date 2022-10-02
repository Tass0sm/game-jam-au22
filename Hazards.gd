extends Area2D



func start(new_position):
	position = new_position
	show()
	$CollisionShape2D.disabled = false
	


func _on_Hazards_body_shape_entered(body_rid, body, body_shape_index, local_shape_index):
	print(body)
	if body.is_in_group("enemies"):
		body.queue_free()
