extends KinematicBody2D

var max_hp
var current_hp 
var time = 0.9

func _ready():
	get_node("AnimationPlayer").play("enemy")
	current_hp = max_hp


func OnHit(damage):
	print("I got hit")
	get_node("AnimationPlayer").play("hit")
	yield(get_tree().create_timer(time), "timeout")
	get_node("AnimationPlayer").play("enemy")
	
