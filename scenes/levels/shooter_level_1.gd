extends Node2D

var enemy = preload("res://scenes/zombies/shooter_enemy.tscn")
var rng = RandomNumberGenerator.new()
var spawn_distance = 1000
var laps = ["0",
[1,0.2,3],#time between each enemy
[0.01,0.01,5,0.01,0.01],
[0.01,2,2,2,2,2,2,2,2,2,2,2],
[1,1.5,1.5,1.5,1.5,1.5],
[0.01,0.01,3,0.01,3,0.01,3,0.01,3,0.01],
[0.01,0.01,3,0.01,3,0.01,3,0.01,2,0.01],
[0.01,0.01,2,0.01,3,0.01,2,0.01,2,0.01],
[0.01,0.01,0.01,5,0.01,0.01,5,0.01,0.01,5,0.01,0.01,5,0.01,0.01],
[0.01,0.01,0.01,4,0.01,0.01,4,0.01,0.01,4,0.01,0.01,4,0.01,0.01],
[0.01,0.01,0.01,3,0.01,0.01,3,0.01,0.01,3,0.01,0.01,3,0.01,0.01]]
var current_lap = 0
var current_enemy = 0
var all_spawned = false
func _ready():
	next_lap()
func spawn_enemy():
	var new_enemy = enemy.instantiate()
	var angle = rng.randf_range(0,PI*2)
	var pos = Vector2(cos(angle), sin(angle))*spawn_distance
	new_enemy.position = pos
	$enemies.add_child(new_enemy)
func next_lap():
	all_spawned = false
	current_lap +=1
	current_enemy =0
	if not laps.size() == current_lap:
		$Gui/BabyHealth.value = 1999
		$Gui/Lap.text = "Lap "+str (current_lap)
		$EnemyTimer.wait_time = laps[current_lap][current_enemy]
		$EnemyTimer.start()
		$Gui/Next_Lap.show()
		await get_tree().create_timer(1).timeout
		$Gui/Next_Lap.hide()
	else:
		won()
func won():
	$Gui/win.show()
func _on_enemy_timer_timeout():
	spawn_enemy()
	current_enemy +=1
	if not laps[current_lap].size() == current_enemy:
		$EnemyTimer.wait_time = laps[current_lap][current_enemy]
		$EnemyTimer.start()
	else:
		all_spawned = true
func check_enemies():
	if $enemies.get_child_count() == 1 and all_spawned:
		next_lap()
		print("ok")

func _on_button_pressed():
	get_tree().change_scene_to_file("res://scenes/menus/titlemenu.tscn")
var heal = load("res://scenes/player/items/heal.tscn")
func add_item():
	
	var new_heal = heal.instantiate()
	var angle = rng.randf_range(0,PI*2)
	var pos = Vector2(cos(angle), sin(angle))*300
	new_heal.position = pos
	add_child(new_heal)


func _on_itemtimer_timeout():
	add_item()
