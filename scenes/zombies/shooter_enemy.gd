extends CharacterBody2D
@onready var health = $health
var speed = 100
var target
var in_view = []
func _ready():
	$Gun/Timer.wait_time = .7
func _physics_process(delta):
	if target:
		$Gun.look_at(target.global_position)
		
		if $Gun.shoot():
			$AnimationPlayer.play("attack")
	else:
		velocity = global_position.direction_to(Vector2(0,0))*speed
		move_and_slide()

func _on_view_body_entered(body):
	if body.is_in_group("family"):
		if target:
			in_view.append(target)
		target = body


func _on_view_body_exited(body):
	if body == target:
		target = null
		if in_view.size() > 0:
			target = in_view[0]
			in_view.remove_at(0)

func get_hit(damage):
	health.value -= damage
	if health.value == 0:
		die()
func die():
	get_parent().get_parent().check_enemies()
	queue_free()


func _on_animation_player_animation_finished(anim_name):
	if anim_name == "attack":
		$AnimationPlayer.play("idle")
