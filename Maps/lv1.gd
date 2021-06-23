extends Node2D



func _ready():
	var player = get_node("YSort/Player")
	#player.position = Vector2(-720,-140)  #original (570,550) #(-720,-140)
	player.modulate = Color(0.56,0.56,0.56)
	player.max_speed = 80
	
	
