extends CharacterBody2D

var zombie

@export var speed = 400.0
@export var health = 100
@export var stamina = 100
@export var damage = 20

var VELOCITY = Vector2.ZERO
var can_play = true
var can_attack = false

func _ready():
	$Healthbar.max_value = health
	$Healthbar.value = health

func _physics_process(_delta):
	$Sword.look_at(get_global_mouse_position())
	$Sword.position = get_global_mouse_position()
	if can_play:
		#Movement System
		if Input.is_action_pressed("right"):
			velocity.x = lerp(velocity.x,speed,0.2)
			$AnimationPlayer.play("idle_right")
		elif Input.is_action_pressed("left"):
			velocity.x = lerp(velocity.x,-speed,0.2)
			$AnimationPlayer.play("idle_left")
		else:
			velocity.x = 0
			
		if Input.is_action_pressed("up"):
			velocity.y = lerp(velocity.y,-speed,0.2)
			$AnimationPlayer.play("idle_up")
		elif Input.is_action_pressed("down"):
			velocity.y = lerp(velocity.y,speed,0.2)
			$AnimationPlayer.play("idle_down")
		else:
			velocity.y = 0
			
		if Input.is_action_just_pressed("boost"):
			if stamina >= 40:
				stamina -= 40
				velocity = velocity * 5
				
		if Input.is_action_just_pressed("attack"):
			if zombie != null:
				$Sword.play("blood")
				zombie.health -= damage
		if Input.is_action_just_released("attack"):
			$Sword.play("default")
		move_and_slide()
			
		#Health and Stamina System
		$Healthbar.value = health
		$Gui/Stamina.value = stamina
		if health <= 0:
			can_play = false
			var deathscreen = load("res://scenes/menus/deathscreen.tscn").instantiate()
			get_parent().add_child(deathscreen)
		if health < 100:
			health += 0.1
		if stamina < 100:
			stamina += 0.2

func _on_area_2d_area_entered(area):
	if "zombie" in area.get_parent().name:
		can_attack = true
		zombie = area.get_parent()

func _on_area_2d_area_exited(area):
	if "zombie" in area.get_parent().name:
		can_attack = false
		zombie = null
