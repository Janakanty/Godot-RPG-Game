extends KinematicBody2D

onready var player = get_parent().get_node("Player")
onready var map_navigation = get_parent().get_parent().get_node("Navigation2D") 
#onready var Quest = get_node("/root/Map/YSort/Player/Camera2D/CanvasLayer/Quest")

var speed = 60
var max_hp = 400
var current_hp 
var percentage_hp = 100
var time = 0.9
var can_fire =  false
var dead = false
var state = "Rest"
var moving = false

var fire_direction = 1
var player_position


var player_in_range
var player_in_sight
var player_seen
var destination
var animation 
var atak = 0
var move_direction = 1 
var damage = 10

var anim_direction = "S"
var anim_mode = "idle_S"

func _ready():
	current_hp = max_hp
	
	
	

func _physics_process(delta):
	SightCheck()
	AnimationLoop()
	

func _process(delta):
	match state:
		"Rest":
			get_node("AnimationPlayer").play("enemy")
			moving = false
			pass
		"Attack":
			if can_fire == true:
				Attack()
				moving = false
			else:
				pass
		"Search":
			Search(delta)
			moving = true
		"Return":
			pass
		"Follow":
			Follow(delta)
			moving = true
	
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
				fire_direction = (get_angle_to(player.get_global_position())/3.14)*180
				move_direction = (get_angle_to(player.get_global_position())/3.14)*180
				destination = map_navigation.get_closest_point(player_position)
				state = "Search"
			else:
				player_in_sight = false
				if player_seen == true:
					state = "Search"
				else: 
					state = "Rest"

func OnHit(damage):
	print(current_hp, " current hp")
	current_hp = current_hp - int(damage)
	if current_hp<1:
		die()
	
	get_node("AnimationPlayer").play("hit")
	yield(get_tree().create_timer(time), "timeout")
	get_node("AnimationPlayer").play("enemy")


func die():
	queue_free();
	
	



func AnimationLoop():  #function for setting the appropriate animation of the player
		
	if can_fire == true:
		anim_mode = "attack"
		if fire_direction <= 15 and fire_direction >= -15:
			anim_direction = "E"
		elif fire_direction <= 60 and fire_direction >= 15:
			anim_direction = "E" #"SE"
		elif fire_direction <= 120 and fire_direction >= 60:
			anim_direction = "S"
		elif fire_direction <= 165 and fire_direction >= 120:
			anim_direction =  "S" #"SW"
		elif fire_direction >= -60 and fire_direction<= -15:
			anim_direction = "N"  #"NE"
		elif fire_direction >= -120 and fire_direction <= -60:
			anim_direction = "N"
		elif fire_direction >= -165 and fire_direction <= -120:
			anim_direction =  "W" #"NW"
		elif fire_direction <= -165 or fire_direction >= 165:
			anim_direction = "W"
			
	else:
		if can_fire == false:
			anim_direction = "S"
			if move_direction <= 15 and move_direction >= -15:
				anim_direction = "E"
			elif move_direction <= 60 and move_direction >= 15:
				anim_direction = "E" #"SE"
			elif move_direction <= 120 and move_direction >= 60:
				anim_direction = "S"
			elif move_direction <= 165 and move_direction >= 120:
				anim_direction = "S" #"SW"
			elif move_direction >= -60 and move_direction <= -15:
				anim_direction = "N"  #"NE"
			elif move_direction >= -120 and move_direction <= -60:
				anim_direction = "N"
			elif move_direction >= -165 and move_direction <= -120:
				anim_direction = "W" #"NW"
			elif move_direction <= -165 or move_direction >= 165:
				anim_direction = "W"
			
		
		if moving == true:
			anim_mode = "walk"
		else: 
			anim_mode = "idle"
		
	animation = anim_mode + "_" + anim_direction
	get_node("AnimationPlayer").play(animation)
	#print(animation)


func _on_Area2D_body_entered(body):
	if body.is_in_group("Player") : 
		can_fire = true
		if((get_angle_to(body.position)/3.14)*180) <= (fire_direction +25) and ((get_angle_to(body.position)/3.14)*180) >= (fire_direction - 25):
			body.OnHit(2)

	
func _on_Sight_body_entered(body):
	if body == player:
		player_in_range = true
		#if Quest.zad_1 == false:
		#	Quest.kill1()
		#	Quest.zad_1 = true
		#	Quest.zad_1 = true
	

func _on_Sight_body_exited(body):
	if body == player:
		player_in_range = false
		if player_seen == true:
			state = "Search"


func _on_Area2D2_body_entered(body):
	if body.is_in_group("Player") : 
		can_fire = true


func _on_Area2D2_body_exited(body):
	if body.is_in_group("Player") : 
		can_fire = false
