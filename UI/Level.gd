extends Control


func show_labels():
	get_tree().paused = true
	$Title.text = Global.levels[Global.level]["title"]
	$Subtitle.text = Global.levels[Global.level]["subtitle"]
	var other_level = get_node_or_null("/root/Game/UI/HUD/Level")
	if other_level != null:
		other_level.hide()
	show()
	$Timer.start()


func _on_Timer_timeout():
	hide()
	get_tree().paused = false

	var other_level = get_node_or_null("/root/Game/UI/HUD/Level")
	if other_level != null:
		other_level.text = Global.levels[Global.level]["title"]
		other_level.show()
