extends StaticBody2D

export (Color,RGB) var mouse_out
export (Color,RGB) var mouse_over

var dialog_is = false
var current_dialogue = ['']
var dialog1=false
var dialog2=false

var Fiona_start =[
	{'text':'...pamętam, że nie mogłem otworzyć tego słoika. Ale ile miałem lat? Chyba byłem mały'},
	{'text':'Był on przezroczysty i bardzo chciałem go otworzyć. Szczerze? Nie za bardzo jestem pewny czy tak wygladał słoik ale...'},
]

var Fiona_end =[
	{'name':'[name]','text':'co mówiłeś? Ał moja głowa! '},
	{'text':'Na co tu jeszcze czekasz? Idź dalej to się dowiesz gdzie jesteś'},
	{'text':'No idź nie czekaj tu w nieskończoność bo się przyzwyczaisz'},
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
	elif dialog2==false:
		current_dialogue=Fiona_end
		
func _on_Area2D_input_event(viewport, event, shape_idx):  #wywołanie dialogu po nacisnieciu w NPC'a
	if (event is InputEventMouseButton && event.button_index == BUTTON_LEFT && event.pressed):
		what_dialogue_should_be()
		var dialog = preload("res://addons/dialogs/Dialog.tscn").instance()
		var camera = get_node("../Player/Camera2D/CanvasLayer")
		dialog.dialog_script=current_dialogue
		camera.add_child(dialog)
		
		
		
	pass # Replace with function body.
