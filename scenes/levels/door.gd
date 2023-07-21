extends Node2D

var player_in_range = false

func _process(delta):
	if player_in_range:
		$dorjoint.rotation = lerp($dorjoint.rotation, deg_to_rad(-90.0), 0.2)
		$dorjoint/StaticBody2D/CollisionShape2D.disabled = true
	else :
		$dorjoint.rotation = lerp($dorjoint.rotation, 0.0, 0.1)
		$dorjoint/StaticBody2D/CollisionShape2D.disabled = false

func _on_area_2d_body_entered(body):
	if body.is_in_group("player"):
		player_in_range = true
	pass # Replace with function body.


func _on_area_2d_body_exited(body):
	if body.is_in_group("player"):
		player_in_range = false
