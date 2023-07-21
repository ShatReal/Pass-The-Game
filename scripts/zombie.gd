extends CharacterBody2D

@onready var player = get_parent().get_node_or_null("player")
@onready var start_pos = global_position
@export var resource : Resource
var health
var size
var damage
var color
var speed
var wandering = false
var wandering_cast = false
var has_seen_player = false
func _ready():
	randomize()
#	Takes stats from resource:
	health = resource.health
	size = resource.size
	damage = resource.damage
	color = resource.color
	speed = resource.speed * 3
	
	$Healthbar.max_value = health
	$Healthbar.value = health
	self.scale = size
	$Sprite2D.modulate = color

func _physics_process(_delta):
	#Detects if zombies should go after player
	Global.enemies_in_range[self] = $"Detection Area".overlaps_body(player)
	
	#Navigation System
	var player_position = player.position
	var target_position = (player_position - position).normalized()
	
	if Global.state == Global.FOLLOW:
		wandering = false
		if position.distance_to(player_position) > 3:
			velocity = target_position * speed * 2
			has_seen_player = true
	
	if Global.state == Global.WANDER:
		if !wandering:
			wandering = true
			wandering_cast = false
		wander()
	move_and_slide()
		
	#Health System
	$Healthbar.value = health
	if health <= 0:
		Global.enemies_in_range.erase(self)
		queue_free()


func _on_attack_timeout():
	player.health -= damage




func _on_area_2d_area_entered(area):
	if area.is_in_group("Player Collision"):
		$Timers/Attack.start()


func _on_area_2d_area_exited(area):
	if area.is_in_group("Player Collision"):
		$Timers/Attack.stop()
	

func wander():
	await get_tree().process_frame
	if !wandering_cast:
		wandering_cast = true
		var random_timer_amount = fmod(randf() * randi(), 2)
		var random_rotation : float
		if has_seen_player:
			random_rotation = randf_range(get_angle_to(player.global_position) / 2, get_angle_to(player.global_position) * 2)
			velocity = Vector2.RIGHT.rotated(random_rotation) * speed * 2
		else:
			random_rotation = randf_range(get_angle_to(start_pos) / 1, get_angle_to(start_pos) * 1.3)
			velocity = Vector2.RIGHT.rotated(random_rotation) * speed * 1
		
		await get_tree().create_timer(random_timer_amount).timeout
		wandering_cast = false
		wander()

func on_hurt(damage):
	health -= damage
	var particle_emitter = $GPUParticles2D.duplicate()
	particle_emitter.global_position = $GPUParticles2D.global_position
	$"../../ParticleEmitters".add_child(particle_emitter)
	particle_emitter.restart()
