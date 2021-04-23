extends StaticBody2D

export (Color,RGB) var mouse_out = Color(1,1,1)
export (Color,RGB) var mouse_over = Color(0.86,0.86,0.86)

var in_range = false



func _ready():
	pass # Replace with function body.



func _on_Area2D_body_entered(body):
	if body.name == "player":
		in_range = true


func _on_Area2D_body_exited(body):
	if body.name == "player":
		in_range = false


func _on_Area2D2_mouse_entered():
	set_modulate(mouse_over)


func _on_Area2D2_mouse_exited():
	set_modulate(mouse_out)


func _on_Area2D2_input_event(viewport, event, shape_idx):
	if (event is InputEventMouseButton && event.button_index == BUTTON_LEFT && event.pressed):
		get_tree().change_scene("res://Maps/lv1.tscn")
