extends CharacterBody2D

@onready var player = get_parent().get_node_or_null("player")
@export var speed = 100
@export var health = 100
@export var damage = 20
@export var size = Vector2(1,1)
@export var color = Color(1,1,1)

func _ready():
	$Healthbar.max_value = health
	$Healthbar.value = health
	self.scale = size
	$Sprite2D.modulate = color

func _physics_process(_delta):
	#Navigation System
	var player_position = player.position
	var target_position = (player_position - position).normalized()
	
	if position.distance_to(player_position) > 3:
		velocity = target_position * speed
		move_and_slide()
		
	#Health System
	$Healthbar.value = health
	if health <= 0:
		queue_free()

func _on_area_2d_area_entered(area):
	if "player" in area.get_parent().name:
		$Timers/Attack.start()

func _on_area_2d_area_exited(area):
	if "player" in area.get_parent().name:
		$Timers/Attack.stop()

func _on_attack_timeout():
	player.health -= damage
