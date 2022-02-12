extends Node

var VP = Vector2.ZERO
var score = 0
var lives = 5
var level = -1
var Player = null

var levels = [
	{
		"title":"Level 1",
		"subtitle":"Destroy the asteroids",
		"asteroids":[Vector2(100,100)],
		"enemies":[],
		"bosses":[],
		"timer":100,
		"asteroids_spawned":false,
		"enemies_spawned":false,
		"bosses_spawned":false
	},
	{
		"title":"Level 2",
		"subtitle":"Destroy the asteroids",
		"asteroids":[Vector2(100,100),Vector2(900,500)],
		"enemies":[],
		"bosses":[],
		"timer":100,
		"asteroids_spawned":false,
		"enemies_spawned":false,
		"bosses_spawned":false
	},
	{
		"title":"Level 3",
		"subtitle":"Destroy the asteroids and watch out for the enemy",
		"asteroids":[Vector2(100,100),Vector2(900,500)],
		"enemies":[Vector2(150,500)],
		"bosses":[],
		"timer":80,
		"asteroids_spawned":false,
		"enemies_spawned":false,
		"bosses_spawned":false
	},
	{
		"title":"Level 4",
		"subtitle":"Destroy the asteroids and watch out for the enemy",
		"asteroids":[Vector2(100,100),Vector2(900,400),Vector2(800,200)],
		"enemies":[Vector2(50,300),Vector2(700,1300)],
		"bosses":[],
		"timer":80,
		"asteroids_spawned":false,
		"enemies_spawned":false,
		"bosses_spawned":false
	},
	{
		"title":"Level 5",
		"subtitle":"Destroy the asteroids and watch out for the enemies",
		"asteroids":[Vector2(100,100),Vector2(900,500),Vector2(800,200)],
		"enemies":[],
		"bosses":[Vector2(200,200)],
		"timer":60,
		"asteroids_spawned":false,
		"enemies_spawned":false,
		"bosses_spawned":false
	}
]


func _ready():
	pause_mode = Node.PAUSE_MODE_PROCESS
	randomize()
	#VP = get_viewport().size
	VP = Vector2(1600,1200)
	var _signal = get_tree().get_root().connect("size_changed", self, "_resize")
	reset()

func _physics_process(_delta):
	var A = get_node_or_null("/root/Game/Asteroid_Container")
	var E = get_node_or_null("/root/Game/Enemy_Container")
	if A != null and E != null:
		var L = levels[level]
		if L["asteroids_spawned"] and A.get_child_count() == 0 and L["enemies_spawned"] and E.get_child_count() == 0:
			next_level()

func reset():
	score = 0
	lives = 5
	level = 2
	for l in levels:
		l["asteroid_spawned"] =  false
		l["enemies_spawned"] = false
		l["bosses_spawned"] = false

func _resize():
	#VP = get_viewport().size
	pass

func update_score(s):
	score += s
	var Score = get_node_or_null("/root/Game/UI/HUD/Score")
	if Score != null:
		Score.text = "Score: " + str(score)

func update_lives(l):
	lives += l
	if lives <= 0:
		var _scene = get_tree().change_scene("res://UI/End_Game.tscn")
	var Lives = get_node_or_null("/root/Game/UI/HUD/Lives")
	if Lives != null:
		Lives.text = "Lives: " + str(lives)

func next_level():
	level += 1 
	if level >= levels.size():
		var _scene = get_tree().change_scene("res://UI/End_Game.tscn")
	else:
		var Level_Label = get_node_or_null("/root/Game/UI/Level")
		if Level_Label != null:
			Level_Label.show_labels()
