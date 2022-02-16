extends Control


func _ready():
	Global.add_score()
	$Label.text = "Your final score was " + str(Global.score) + "."
	$Scores.text = "High Scores:\n"
	var count = 0
	for score in Global.scores:
		if count < 5:
			$Scores.text = $Scores.text + str(score["score"]) + "\n"
			count += 1
	get_tree().paused = false


func _on_Play_pressed():
	Global.reset()
	get_tree().paused = false
	var _scene = get_tree().change_scene("res://UI/Selector.tscn")


func _on_Quit_pressed():
	get_tree().quit()

