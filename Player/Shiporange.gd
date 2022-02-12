extends KinematicBody2D

var velocity = Vector2.ZERO

var rotation_speed = 5.0
var speed = 5.0
var max_speed = 400.0

var health = 10
var shields = 0
var shield_regen = 0.01
var shield_max = 50.0
var shield_textures = [
	preload("res://Assets/shield1.png"),
	preload("res://Assets/shield2.png"),
	preload("res://Assets/shield3.png")
]


var Effects = null
onready var Explosion = load("res://Effects/Explosion.tscn")

onready var Bullet = load("res://Player/Bullet.tscn")
var nose = Vector2(0,-60)



func _ready():
	pass

func _physics_process(_delta):
	velocity = velocity + get_input()*speed
	velocity = velocity.normalized() * clamp(velocity.length(), 0, max_speed)
	velocity = move_and_slide(velocity, Vector2.ZERO)
	position.x = wrapf(position.x, 0, Global.VP.x)
	position.y = wrapf(position.y, 0, Global.VP.y)
	
	shields = clamp(shields + shield_regen,-100,shield_max)
	if shields >= shield_max:
		$Shield.hide()
	elif shields >= shield_max * 0.75:
		$Shield.show()
		$Shield/Sprite.texture = shield_textures[2]
	elif shields >= shield_max * 0.4:
		$Shield.show()
		$Shield/Sprite.texture = shield_textures[1]
	elif shields >= 0:
		$Shield.show()
		$Shield/Sprite.texture = shield_textures[0]
	else:
		$Shield.hide()


	if Input.is_action_just_pressed("shoot"):
		Effects = get_node_or_null("/root/Game/Effects")
		if Effects != null:
			var bullet = Bullet.instance()
			bullet.global_position = global_position + nose.rotated(rotation)
			bullet.rotation = rotation
			Effects.add_child(bullet)


func get_input():
	var to_return = Vector2.ZERO
	$Exhaust.hide()
	if Input.is_action_pressed("forward"):
		to_return.y -= 1
		$Exhaust.show()
	if Input.is_action_pressed("backward"):
		to_return.y += 1
	if Input.is_action_pressed("left"):
		rotation_degrees = rotation_degrees - rotation_speed
	if Input.is_action_pressed("right"):
		rotation_degrees = rotation_degrees + rotation_speed
	return to_return.rotated(rotation)

func damage(d):
	health -= d
	if health <= 0:
		Effects = get_node_or_null("/root/Game/Effects")
		if Effects != null:
			var explosion = Explosion.instance()
			Effects.add_child(explosion)
			explosion.global_position = global_position
			hide()
			yield(explosion, "animation_finished")
		Global.update_lives(-1)
		Global.update_score(-50)
		queue_free()

func _on_Area2D_body_entered(body):
	if body.name != "Player":
		if body.has_method("damage"):
			body.damage(5)
		damage(5)

func _on_Shield_area_entered(area):
	if "damage" in area and not area.is_in_group("friendly") and shields >= 0:
		shields -= area.damage
		area.queue_free()

func _on_Shield_body_entered(body):
	if body != self and not body.is_in_group("friendly") and body.has_method("damage") and shields >= 0:
		shields -= 100
		body.damage(100)
