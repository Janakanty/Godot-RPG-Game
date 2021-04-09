extends KinematicBody2D

onready var player = get_parent().get_node("Player")
onready var map_navigation = get_parent().get_parent().get_node("Navigation2D") 
onready var Quest = get_node("/root/Map/YSort/Player/Camera2D/CanvasLayer/Quest")

var speed = 30
var max_hp = 400
var current_hp 
var percentage_hp = 100
var time = 0.9
var can_fire =  true
var dead = false
var state = "Rest"

var fire_direction
var player_position


var player_in_range
var player_in_sight
var player_seen
var destination

func _ready():
	get_node("AnimationPlayer").play("enemy")
	current_hp = max_hp
	
	
	

func _physics_process(delta):
	SightCheck()
	

func _process(delta):
	match state:
		"Rest":
			get_node("AnimationPlayer").play("enemy")
			pass
		"Attack":
			if can_fire == true:
				Attack()
			else:
				pass
		"Search":
			Search(delta)
		"Return":
			pass
		"Follow":
			Follow(delta)
	
	#
	# FUNKCJE MOŻLIWOŚĆI WROGA
	#
func Attack(): 
	speed = 120
	get_node("AnimationPlayer").play("attack")
	
func Search(delta):
	var path_to_destination = map_navigation.get_simple_path(get_global_position(), destination)
	var starting_point = get_global_position()
	var move_distance = speed * delta
	
	for point in range(path_to_destination.size()):
		var distance_to_next_point = starting_point.distance_to(path_to_destination[0])
		if move_distance <= distance_to_next_point:
			var move_rotation = get_angle_to(starting_point.linear_interpolate(path_to_destination[0], move_distance/ distance_to_next_point))
			var motion = Vector2(speed,0).rotated(move_rotation)
			move_and_slide(motion)
			break
		move_distance -= distance_to_next_point
		starting_point = path_to_destination[0]
		path_to_destination.remove(0)
		
	if path_to_destination.size() == 0:
		player_seen = false
		state = "Rest"
		
func Follow(delta):
	if player_seen == true:
		move_and_slide(destination)
	#
	# SZTUCZNA INTELIGENCJA 
	#
	
func SightCheck(): 
	if player_in_range ==true:
		var space_state = get_world_2d().direct_space_state #Bezpośredni dostęp do fizycznego stanu przestrzeni 2D na świecie.
		var sight_check = space_state.intersect_ray(global_position, player.get_node("CollisionPolygon2D").global_position, [self], collision_mask) #Służy głównie do wykonywania zapytań dotyczących obiektów i obszarów znajdujących się w danej przestrzen
		if sight_check:
			if sight_check.collider.name == "Player":
				player_in_sight = true
				player_seen = true
				player_position = player.get_global_position()
				destination = map_navigation.get_closest_point(player_position)
				state = "Search"
			else:
				player_in_sight = false
				if player_seen == true:
					state = "Search"
				else: 
					state = "Rest"

func OnHit(damage):
	print(current_hp)
	current_hp = current_hp - int(damage)
	if current_hp<1:
		die()
	
	get_node("AnimationPlayer").play("hit")
	yield(get_tree().create_timer(time), "timeout")
	get_node("AnimationPlayer").play("enemy")


func die():
	queue_free();
	Quest.kill1_end()
	
	

	
func _on_MelleRange_body_entered(body):
	if body.is_in_group("Player") : 
		body.OnHit(30)
		
		

func _on_Sight_body_entered(body):
	if body == player:
		player_in_range = true
		if Quest.zad_1 == false:
			Quest.kill1()
			Quest.zad_1 = true
	

func _on_Sight_body_exited(body):
	if body == player:
		player_in_range = false
		if player_seen == true:
			state = "Search"

