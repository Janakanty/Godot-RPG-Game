extends Node2D



func _ready():
	var player = preload("res://Player/Player.tscn").instance()
	var scene = $YSort/Players
	scene.add_child(player)
	player.position = Vector2(533,550)
	player.modulate = Color(0.56,0.56,0.56)
	player.max_speed = 80
