extends StaticBody2D

func _on_Area2D_body_entered(body):
	if body.name == "Player":
		$sciana.modulate.a8 = 100


func _on_Area2D_body_exited(body):
	if body.name == "Player":
		$sciana.modulate.a8 = 255
