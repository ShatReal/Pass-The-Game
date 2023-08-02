extends Control


func _ready():
	if Global.config.music:
		$MusicSwitch/CheckButton.button_pressed = true
	if Global.config.sound:
		$SoundSwitch/CheckButton.button_pressed = true

func _on_button_pressed():
	get_tree().change_scene_to_file("res://scenes/levels/level_1.tscn")


func _on_shooter_pressed():
	get_tree().change_scene_to_file("res://scenes/levels/shooter_level_1.tscn")


func _on_dont_click_me_button_up():
	print("Please dont poke the baby")
	$DontClickMe/AudioStreamPlayer2D.play()


func _on_music_button_button_up():
	Global.set_music($MusicSwitch/CheckButton.button_pressed)
	Global.save_config()



func _on_sound_button_button_up():
	Global.set_sound($SoundSwitch/CheckButton.button_pressed)
	Global.save_config()
