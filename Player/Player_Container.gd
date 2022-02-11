extends Node2D


func _physics_process(_delta):
	if get_child_count() == 0 and Global.Player != null:
		var player = Global.Player.instance()
		player.position = Vector2(Global.VP.x/2,Global.VP.y/2)
		add_child(player)
