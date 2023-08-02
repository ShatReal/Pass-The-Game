extends Area2D

var speed = 750
var damage = 10
var active = true

func _ready():
	$AnimationPlayer.play("RESET")

func _physics_process(delta):
	if active:
		position += transform.x * speed * delta

func _on_body_entered(body):
	if body.is_in_group("enemy") or body.is_in_group("family"):
		body.get_hit(damage)
	
	active = false
	$AnimationPlayer.play("hit")
	$SoundHit.play()


func _on_timer_timeout():
	queue_free()


func _on_animation_player_animation_finished(anim_name):
	if anim_name == "hit":
		_on_timer_timeout()
