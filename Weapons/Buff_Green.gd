extends Area2D


func _ready():
	pass


func _on_Buff_Red_body_entered(body):
	if body.name == "Player" and body.has_method("buff_green"):
		body.buff_green()
		queue_free()
