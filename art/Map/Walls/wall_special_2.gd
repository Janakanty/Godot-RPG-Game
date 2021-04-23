extends StaticBody2D

export (Color,RGB) var mouse_out = Color(1,1,1)
export (Color,RGB) var mouse_over = Color(0.56,0.56,0.56)

var koniec = false


func _ready():
	pass 



func _on_Area2D_body_entered(body):
		if body.name == "Player":
			while modulate.a8 > 0:
				modulate.a8 -= 7
				yield(get_tree().create_timer(0.01), "timeout")
			#$Sprite.modulate.a8 = 0


func _on_Area2D_body_exited(body):
		if body.name == "Player":
			while modulate.a8 < 255:
				modulate.a8 += 7
				yield(get_tree().create_timer(0.01), "timeout")
				#$Sprite.modulate.a8 = 255
