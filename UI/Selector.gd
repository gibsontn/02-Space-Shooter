extends Control


func _ready():
	pass


func _on_Shiporange_pressed():
	Global.Player = load("res://Player/Shiporange.tscn")
	var _scene = get_tree().change_scene("res://Game.tscn")


func _on_Shipgreen_pressed():
	Global.Player = load("res://Player/Shipgreen.tscn")
	var _scene = get_tree().change_scene("res://Game.tscn")


func _on_Shipyellow_pressed():
	Global.Player = load("res://Player/Shipyellow.tscn")
	var _scene = get_tree().change_scene("res://Game.tscn")
