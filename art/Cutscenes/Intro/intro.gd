extends Node2D




func _ready():
	$AnimationPlayer.play("intro")
	var waitstart = 39
	yield(get_tree().create_timer(waitstart), "timeout")
	get_tree().change_scene("res://Map.tscn")	
		
		
func stop_rain():
	get_node("Particles2D").queue_free()


