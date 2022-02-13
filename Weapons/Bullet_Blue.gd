extends Area2D

var velocity = Vector2(0,-600.0)
var speed = 500.0
var damage = 0.5

onready var Explosion = load("res://Effects/Explosion.tscn")
var Effects = null


func _physics_process(delta):
	position += velocity.rotated(rotation)*delta
	position.x = wrapf(position.x, 0, Global.VP.x)
	position.y = wrapf(position.y, 0, Global.VP.y)
	


func _on_Bullet_body_entered(body):
	if body.has_method("damage"):
		body.damage(damage)
	Effects = get_node_or_null("/root/Game/Effects")
	if Effects != null:
		var explosion = Explosion.instance()
		Effects.add_child(explosion)
		explosion.global_position = global_position
	queue_free()


func _on_Timer_timeout():
	queue_free()


