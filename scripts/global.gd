extends Node

enum {
	FOLLOW,
	WANDER
}
var enemies_in_range : Dictionary
var state = WANDER

func _process(delta):
	if true in enemies_in_range.values():
		state = FOLLOW
	else:
		state = WANDER


