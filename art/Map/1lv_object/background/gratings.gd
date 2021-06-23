extends StaticBody2D



func _on_Area2D_body_entered(body):
	if body.is_in_group("Player"):
		get_node("/root/Map/YSort/Player").max_speed = 70
		


func _on_Area2D_body_exited(body):
	if body.is_in_group("Player"):
		get_node("/root/Map/YSort/Player").max_speed = 120
