extends StaticBody2D

export (Color,RGB) var mouse_out
export (Color,RGB) var mouse_over

var current_dialogue = ['']
var dialog1=false
var dialog2=false


var Covon_start = [
	{
		'background': "res://art/Sprites_NPC/portraitCOVON.png"
	},
	
	{'text': 'No no no, kogo my tu mamy! Wreszcie się obudziłeś. Fiona miała mieć na Ciebie oko.'},
	{'text':'Spróbuj nie broić. Nasza siedziba znajduje się za tym przejściem, ale Bob Cie nie wpuści'},
	{'text':'Pierw musisz wejść do groty. Takie mamy tu zasady. Bez imienia Cię nie wpuścimy'},
	{'text':'zrozumiałeś?'},	
	{
		'background': "res://art/Sprites/portrait.png"
	},
	{'text':'...'},	
	{
		'background': "res://art/Sprites_NPC/portraitCOVON.png"
	},
	{'text':'To świetnie! Do zobaczenia potem!'},
]

var Covon_click2 =[
	{
		'background': "res://art/Sprites_NPC/portraitCOVON.png"
	},
	{'text': 'Ruchy rychy! Nie marnuj czasu!'},
]


var Covon_click3 =[
	{
		'background': "res://art/Sprites_NPC/portraitCOVON.png"
	},
	{'text': 'Ruchy rychy! Nie mamy całej wieczności!... A może mamy?'},
	{
		'background': "res://art/Sprites/portrait.png"
	},
	{'name':'hero','text':'Kim ty jesteś? Kim ja jestem?'},
	{
		'background': "res://art/Sprites_NPC/portraitCOVON.png"
	},
	{'name':'Covon','text':'Sluchaj, ja nie jestem tu od przypominania Ci kim jesteś. Idź do Samiry ona podpowie Ci jak odzyskać pamięć.'},
	{'name':'Covon','text':'Ja nazywam się Covon. Ale bez przesady, swoje imie powinieneś pamiętać. Czyż nie?'},
	{
	'input': 'Jak masz na imię?',
	'window_title': 'Wpisz swoje imie',
	'variable': 'name'
	},
	{'name':'Covon','text':'A więc witaj [name] . Tak jak mówiłem. Przejdź się tu trochę i wróć do mnie'},
	{'name':'Covon','text':'Na pewno będę miał tu jakieś zadanie dla Ciebie'},
	{
		'background': "res://art/Sprites/portrait.png"
	},
	{'name':'[name]','text':'...'},
	
	
]


func _on_Area2D_mouse_entered(): #Zmienia kolor postaci po najechaniu myszką 
	set_modulate(mouse_over)
	pass

func _on_Area2D_mouse_exited(): #Zmienia kolor postaci po odjechaniu myszką 
	set_modulate(mouse_out)
	pass

func what_dialogue_should_be(): #system wyboru, który dialog powinien teraz się wczytać
	if dialog1==false:
		current_dialogue=Covon_start
		dialog1=true
	elif dialog2==false:
		current_dialogue=Covon_click2

		
func _on_Area2D_input_event(viewport, event, shape_idx):  #wywołanie dialogu po nacisnieciu w NPC'a
	if (event is InputEventMouseButton && event.button_index == BUTTON_LEFT && event.pressed):
		what_dialogue_should_be()
		var dialog = preload("res://addons/dialogs/Dialog.tscn").instance()
		var camera = get_node("../Player/Camera2D/CanvasLayer")
		dialog.dialog_script=current_dialogue
		camera.add_child(dialog)
			
			
		
		
	pass # Replace with function body.
