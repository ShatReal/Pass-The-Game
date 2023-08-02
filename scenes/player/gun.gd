extends Node2D
var bullet = preload("res://scenes/player/bullet.tscn")
var can_shoot = true
func shoot() -> bool:
	if can_shoot:
		can_shoot = false
		$Timer.start()
		var b = bullet.instantiate()
		b.global_position = $pos.global_position
		b.global_rotation =$pos.global_rotation
		get_tree().current_scene.add_child(b)
		return true
	return false

func _on_timer_timeout():
	can_shoot = true
