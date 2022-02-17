extends Node

const SCORES = "user://scores.sav"
const SECRET = "I LOVE PROJECT 02"

var scores = []

var VP = Vector2.ZERO
var score = 0
var lives = 5
var level = -1
var Player = null

var levels = [
	{
		"title":"Level 1",
		"subtitle":"Destroy the asteroid!",
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
		"subtitle":"Destroy the asteroids!",
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
		"subtitle":"Destroy the asteroids and watch out for the enemy!",
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
		"subtitle":"Destroy the asteroids and watch out for the enemies!",
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
		"subtitle":"Destroy the asteroids and watch out for the Boss!",
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
	level = -1
	for l in levels:
		l["asteroids_spawned"] =  false
		l["enemies_spawned"] = false
		l["bosses_spawned"] = false
	load_scores()

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
		for c in Lives.get_children():
			c.queue_free()
		var Life = load("res://UI/Life.tscn")
		for l in range(lives):
			var life = Life.instance()
			var starting = Lives.rect_size.x - (40*(l+1))
			life.position.x = starting
			Lives.add_child(life)

func next_level():
	level += 1 
	if level >= levels.size():
		var _scene = get_tree().change_scene("res://UI/End_Game.tscn")
	else:
		var Level_Label = get_node_or_null("/root/Game/UI/Level")
		if Level_Label != null:
			Level_Label.show_labels()


func add_score():
	var temp = []
	var trailer = 1000000000
	var added = false
	for s in scores:
		if score < trailer and score > s["score"]:
			temp.append({"score":score})
		temp.append(s)
		trailer = s["score"]
	if not added:
		temp.append({"score":score})
	scores = temp
	save_scores()

func load_scores():
	var save_scores = File.new()
	if not save_scores.file_exists(SCORES):
		return
	
	save_scores.open_encrypted_with_pass(SCORES, File.READ, SECRET)
	var contents = save_scores.get_as_text()
	var json_contents = JSON.parse(contents)
	if json_contents.error == OK:
		scores = json_contents.result
	save_scores.close()
	
func save_scores():
	var save_scores = File.new()
	save_scores.open_encrypted_with_pass(SCORES, File.WRITE, SECRET)
	save_scores.store_string(to_json(scores))
	save_scores.close()
