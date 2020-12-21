extends Control
var NPC
var who = "NN"
var active = false
var what_dialogue = [
	'']

var dialog_index = -1
var finished = false

var who_says = "bohater"

func _ready():
	load_dialog()
	

func _process(delta):
	$"tonextdialog".visible = finished
	if Input.is_action_just_pressed("ui_accept") or Input.is_action_just_pressed("Click") :
		load_dialog()
	
func load_dialog(): #funkcja wczytującca dialog
	var stop_player = get_node("/root/Map/YSort/Player")
	stop_player.stop_player()
	if dialog_index < what_dialogue.size():
		finished = false
		$RichTextLabel.bbcode_text = what_dialogue[dialog_index]
		$RichTextLabel.percent_visible = 0
		$Tween.interpolate_property(
			$RichTextLabel, "percent_visible", 0, 1, 1, 
			Tween.TRANS_LINEAR, Tween.EASE_IN_OUT	
		)
		$Tween.start()
	else:
		get_parent().queue_free()
		NPC.dialog_is = false
		
		
	dialog_index += 1 
	



func _on_Tween_tween_completed(object, key):
	finished = true
