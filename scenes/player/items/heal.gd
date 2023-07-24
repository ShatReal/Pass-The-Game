extends Area2D



func _on_body_entered(body):
	if body.is_in_group("family"):
		body.get_hit(-50)
		queue_free()
