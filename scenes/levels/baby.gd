extends StaticBody2D
@onready var health = get_parent().get_node("Gui/BabyHealth")

func get_hit(damage):
	$HealTimer.start()
	health.value -= damage
	if health.value == 0:
		die()
func die():
	var deathscreen = load("res://scenes/menus/deathscreen.tscn").instantiate()
	get_parent().add_child(deathscreen)


func _on_heal_timer_timeout():
	health.value += 20
