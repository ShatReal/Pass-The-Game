extends Button




func _on_pressed():
	var v = get_parent().get_parent().get_node("how").visible
	if v:
		get_parent().get_parent().get_node("how").visible = false
	else :
		get_parent().get_parent().get_node("how").visible = true
