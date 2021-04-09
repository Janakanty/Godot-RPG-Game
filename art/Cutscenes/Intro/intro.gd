extends Node2D




func _ready():
	$AnimationPlayer.play("intro")
	
func stop_rain():
	get_node("Particles2D").queue_free()


