extends Control
class_name Quest1

onready var text = get_node("ColorRect/VBoxContainer/Label") # zmienna tekstu labelki


func _ready():
	print("yoolo")

var zad_1 = false
var potwory = 0	

func kill1():
	#get_node("/root/Map/YSort/Player/Camera2D/CanvasLayer/Control").queue_free()
	var text = get_node("ColorRect/VBoxContainer/Label")
	text.text = "Zabij potwora"
	get_node(".").visible = true
	

func kill1_end():
	potwory = potwory + 1
	if potwory == 3:
		text.text = "udało się!"
		var waitstart = 3
		print (waitstart)
		yield(get_tree().create_timer(waitstart), "timeout")
		get_node(".").visible = false

