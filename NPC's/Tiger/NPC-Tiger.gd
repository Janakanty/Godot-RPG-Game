extends StaticBody2D

export (Color,RGB) var mouse_out
export (Color,RGB) var mouse_over

var dialog_is = false
var current_dialogue = ['']
var entered = false
var dialog1=false
var dialog2=false

var Fiona_start =[
	{
		'background': "res://art/Sprites_NPC/portrairFIONA.png"
	},
	{'text':'...O'},
	{
		'background': "res://art/Sprites/portrait.png"
	},
	{'text':'...?'},
	{
		'background': "res://art/Sprites_NPC/portrairFIONA.png"
	},
	{'text':'A nie byłeś przypadkiem martwy?'},
	{'text':'Cóż, nie szkodzi, na początku wszyscy są martwi, więc nie musisz się przejmować, ja jestem Fiona, a ty?'},
	{
		'background': "res://art/Sprites/portrait.png"
	},
	{'text':'...'},
	{
		'background': "res://art/Sprites_NPC/portrairFIONA.png"
	},
	{'name':'Fiona','text':'A no tak! Zapomniałam, nic nie pamiętasz. Daj mi dać sobie radę i idź czym prędzej do groty.'},
	{'name':'Fiona','text':'Tam na pewno sobie przypomnisz jak odpowiadać na pytania. Potem tu wróć to pogadamy'},
	
]

var Fiona_end =[
	{
		'background': "res://art/Sprites_NPC/portrairFIONA.png"
	},
	{'name':'Fiona','text':'Co mówiłeś?'},
	{'name':'Fiona','text':'Nie rozumiem cię! Idź do groty. Jak wrócisz to porozmawiamy'},
]

func _on_Area2D_mouse_entered(): #Zmienia kolor postaci po najechaniu myszką 
	set_modulate(mouse_over)
	pass

func _on_Area2D_mouse_exited():  #Zmienia kolor postaci po odjechaniu myszką 
	set_modulate(mouse_out)
	pass

func what_dialogue_should_be(): #system wyboru, który dialog powinien teraz się wczytać
	if dialog1==false:
		current_dialogue=Fiona_start
		dialog1=true
		entered=true
	elif dialog2==false:
		current_dialogue=Fiona_end
		
func _on_Area2D_input_event(viewport, event, shape_idx):  #wywołanie dialogu po nacisnieciu w NPC'a
	if (event is InputEventMouseButton && event.button_index == BUTTON_LEFT && event.pressed):
		what_dialogue_should_be()
		var dialog = preload("res://addons/dialogs/Dialog.tscn").instance()
		var camera = get_node("../Player/Camera2D/CanvasLayer")
		dialog.dialog_script=current_dialogue
		camera.add_child(dialog)
		
func _on_Area2D2_body_entered(body):
	if body.name=="Player" and entered==false:
		what_dialogue_should_be()
		var dialog = preload("res://addons/dialogs/Dialog.tscn").instance()
		var camera = get_node("../Player/Camera2D/CanvasLayer")
		dialog.dialog_script=current_dialogue
		camera.add_child(dialog)
		entered = true
		

