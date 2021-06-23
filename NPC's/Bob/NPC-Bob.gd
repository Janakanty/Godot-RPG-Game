extends StaticBody2D

export (Color,RGB) var mouse_out = Color(1,1,1)
export (Color,RGB) var mouse_over = Color(0.56,0.56,0.56)

var current_dialogue = ['']
var dialog1=false
var dialog2=false
var dialog3=false


var Bob_start = [
	{
		'background': "res://art/Sprites_NPC/portraitBOB.png"
	},
	
	{'text': 'Przejścia nie ma.'},

]

var Bob_click2 =[
	{
		'background': "res://art/Sprites_NPC/portraitBOB.png"
	},
	{'text': 'Nie widzisz, że tu stoję? Podaj Covonovi swoje imię to Cię puszczę'},
]


var Bob_click3 =[
	{
		'background': "res://art/Sprites_NPC/portraitBOB.png"
	},
	{'text': 'Im szybciej to zrobisz tym szybciej ja wrócę do moich zajęć'},
	
]


func _on_Area2D_mouse_entered(): #Zmienia kolor postaci po najechaniu myszką 
	set_modulate(mouse_over)
	$AnimatedSprite.play("Bobsleep")
	yield(get_tree().create_timer(2), "timeout")
	$AnimatedSprite.play("Bob")
	pass

func _on_Area2D_mouse_exited(): #Zmienia kolor postaci po odjechaniu myszką 
	set_modulate(mouse_out)
	pass

func what_dialogue_should_be(): #system wyboru, który dialog powinien teraz się wczytać
	if dialog1==false:
		current_dialogue=Bob_start
		dialog1=true
	elif dialog2==false:
		current_dialogue=Bob_click2
		dialog2=true
	elif dialog3==false:
		current_dialogue=Bob_click3

		
func _on_Area2D_input_event(viewport, event, shape_idx):  #wywołanie dialogu po nacisnieciu w NPC'a
	if (event is InputEventMouseButton && event.button_index == BUTTON_LEFT && event.pressed):
		what_dialogue_should_be()
		var dialog = preload("res://addons/dialogs/Dialog.tscn").instance()
		var camera = get_node("../Player/Camera2D/CanvasLayer")
		dialog.dialog_script=current_dialogue
		camera.add_child(dialog)
			
			
		
		
	pass # Replace with function body.

