class_name player
extends CharacterBody2D


@export var speed = 400.0
@export var health = 100
@export var stamina = 100
@export var damage = 20
var striking = false
var direction = Vector2.ZERO
var can_play = true
var can_attack = true
var hit_enemies = []
var blody_sword = preload("res://assets/textures/SwordBlood.png")
var food = 0
var starve_time = 30

func _ready():
	$Healthbar.max_value = health
	$Healthbar.value = health

func _physics_process(_delta):
	sword_stuff()
	
	$Gui/food_Label.text = "food: " + str(food)
	$Gui/Label.text = "Kid will starve in: " + str(starve_time)
	
	if can_play:
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
			
		if Input.is_action_just_pressed("boost"):
			if stamina >= 40:
				stamina -= 40
				velocity = velocity * 10
				
		if Input.is_action_just_pressed("attack") && can_attack:
			strike()
			can_attack = false
			
		if striking:
			if $"Sword Pivot/Sword/Area2D".has_overlapping_bodies():
				var zombie = $"Sword Pivot/Sword/Area2D".get_overlapping_bodies()[0]
				if not zombie in hit_enemies:
					if zombie.is_in_group("Zombies"):
						$"Sword Pivot/Sword".texture = blody_sword
						zombie.on_hurt(damage)
						hit_enemies.append(zombie)
		
		
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



func sword_stuff():
	if not striking: $"Sword Pivot".look_at(get_global_mouse_position())


func strike():
	$"Sword Pivot/Sword/AnimationPlayer".play("Strike")
	striking = true
	await get_tree().create_timer(3).timeout
	can_attack = true
	hit_enemies.clear()

	


func _on_animation_player_animation_finished(anim_name):
	if anim_name == "Strike":
		striking = false


func _on_starve_timeout():
	starve_time -= 1
	if starve_time == 0:
		can_play = false
		var deathscreen = load("res://scenes/menus/deathscreen.tscn").instantiate()
		get_parent().add_child(deathscreen)

func _on_area_2d_2_body_entered(body):
	if body.is_in_group("kid"):
		print("mom")
		starve_time += food * 30
		food = 0
