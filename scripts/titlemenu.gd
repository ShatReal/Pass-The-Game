extends Control

func _on_button_pressed():
	get_tree().change_scene_to_file("res://scenes/levels/level_1.tscn")


func _on_shooter_pressed():
	get_tree().change_scene_to_file("res://scenes/levels/shooter_level_1.tscn")