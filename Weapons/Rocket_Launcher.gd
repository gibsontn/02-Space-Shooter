extends Node2D

var Effects = null
onready var Rocket = load("res://Weapons/Rocket.tscn")

var ready = true

func _ready():
	pass

func shoot(rot, pos):
	Effects = get_node_or_null("/root/Game/Effects")
	if Effects != null:
		if ready:
			var bullet = Rocket.instance()
			bullet.rotation = rot - PI/2
			bullet.global_position = pos
			Effects.add_child(bullet)
			ready = false
			$Timer.start()

func _on_Timer_timeout():
	ready = true
