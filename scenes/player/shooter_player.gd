extends CharacterBody2D


@export var speed = 400.0
#@export var health = get_parent().get_node("Gui/player_health")
@export var stamina = 100
@export var damage = 20

var direction = Vector2.ZERO
# Get the gravity from the project settings to be synced with RigidBody nodes.
var gravity = ProjectSettings.get_setting("physics/2d/default_gravity")


func _physics_process(delta):
	
#	if can_play:
		direction = Input.get_vector("left", "right", "up", "down").normalized()
		velocity = lerp(velocity, direction * speed, 0.2)
		
		#Movement System
		if Input.is_action_pressed("right"):
			$AnimationPlayer.play("idle_right")
		elif Input.is_action_pressed("left"):
			$AnimationPlayer.play("idle_left")

		if Input.is_action_pressed("up"):
			$AnimationPlayer.play("idle_up")
		elif Input.is_action_pressed("down"):
			$AnimationPlayer.play("idle_down")

		move_and_slide()
		if Input.is_action_pressed("attack"):
			$Gun.shoot()
		$Gun.look_at(get_global_mouse_position())
func get_hit(damage):
	$HealTimer.start()
	get_parent().get_node("Gui/player_health").value -= damage
	if get_parent().get_node("Gui/player_health").value == 0:
		die()
func die():
	queue_free()


func _on_heal_timer_timeout():
	get_parent().get_node("Gui/player_health").value += 20
