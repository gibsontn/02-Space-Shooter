extends Node

var VP = Vector2.ZERO
var score = 0
var lives = 5
var level = -1

var levels = [
	{
		"title":"Level 1",
		"subtitle":"Destroy the asteroids",
		"asteroids":[Vector2(100,100),Vector2(900,500)],
		"enemies":[],
		"timer":100,
		"asteroids_spawned":false,
		"enemies_spawned":false
	},
	{
		"title":"Level 2",
		"subtitle":"Destroy the asteroids and watch out for the enemy",
		"asteroids":[Vector2(100,100),Vector2(900,500),Vector2(800,200)],
		"enemies":[Vector2(150,500)],
		"timer":80,
		"asteroids_spawned":false,
		"enemies_spawned":false
	},
]


func _ready():
	pause_mode = Node.PAUSE_MODE_PROCESS
	randomize()
	VP = get_viewport().size
	var _signal = get_tree().get_root().connect("size_changed", self, "_resize")
	reset()

func reset():
	get_tree().paused = false
	score = 0
	lives = 5
	level = -1
	for l in levels:
		l["asteroid_spawned"] =  false
		l["enemies_spawned"] = false

func _resize():
	VP = get_viewport().size

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
	if level > levels.size():
		var _scene = get_tree().change_scene("res://UI/End_Game.tscn")
	var Level_Label = get_node_or_null("/root/Game/UI/Level")
	if Level_Label != null:
		Level_Label.show_labels()
