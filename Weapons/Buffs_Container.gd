extends Node2D

onready var Buff = load("res://Weapons/Buff_Green.tscn")

func _physics_process(_delta):
	if get_child_count() == 0:
		var buff = Buff.instance()
		buff.position = Vector2(randf()*Global.VP.x, randf()*Global.VP.y)
		add_child(buff)
