extends Area2D

var speed = 750
var damage = 10
func _physics_process(delta):
	position += transform.x * speed * delta

func _on_body_entered(body):
	if body.is_in_group("enemy") or body.is_in_group("family"):
		body.get_hit(damage)
	queue_free()


func _on_timer_timeout():
	queue_free()
