extends Area2D


onready var body = get_node("/root/Map/YSort/Player")
var wall = get_tree().get_root()

func _ready():
	pass

func _process(delta):
	set_physics_process(true)
	
func set_physics_process(delta):
	
	if(overlaps_body(body)==true): 
		print("true")
		wall.$Sprite.modulate.a8 = 100
	else:
		print("false")
		wall.$Sprite.modulate.a8 = 255


