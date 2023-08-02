extends Node

enum {
	FOLLOW,
	WANDER
}
var enemies_in_range : Dictionary
var state = WANDER



var config: Dictionary = {
	"music": true,
	"sound": true
}

func _ready():
	load_config()
	set_music(config.music)
	set_sound(config.sound)

func load_config():
	if not FileAccess.file_exists("user://config.cfg"):
		save_config()
		return
	var file := FileAccess.open("user://config.cfg", FileAccess.READ)
	config = JSON.new().parse_string(file.get_as_text())


func save_config():
	var file := FileAccess.open("user://config.cfg", FileAccess.WRITE)
	file.store_string(JSON.stringify(config, "\t"))

func set_music(target):
	config.music = target
	AudioServer.set_bus_mute(1, !target)

func set_sound(target):
	config.sound = target
	AudioServer.set_bus_mute(2, !target)

func _process(delta):
	if true in enemies_in_range.values():
		state = FOLLOW
	else:
		state = WANDER


