extends Area2D



func _on_body_entered(body):
	if body.is_in_group("family"):
		body.get_hit(-50)
		$AnimationPlayer.play("pickup")


func _on_animation_player_animation_finished(anim_name):
	if anim_name == "pickup":
		queue_free()
