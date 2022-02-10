extends Control

func _ready():
	Global.update_score(0)
	Global.update_lives(0)


func update_score():
	$Score.text = "Score: " + str(Global.score)


func update_lives():
	$Lives.text = "Lives: " + str(Global.lives)

