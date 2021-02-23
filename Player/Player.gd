extends KinematicBody2D

export var speed = 0  # How fast the player will move (pixels/sec).
var max_speed = 140
var acceleration = 1299
var move_direction 
var fire_direction = 0
var moving = false
var destination = Vector2()
var movement = Vector2()
var screen_size  # Size of the game window.
var animation 
var selected_skill = "NoWeapon"
var can_fire = true
var shooting = false
var melee = false
var damage
var rate_of_fire = 0.55     

var anim_direction = "S"
var anim_mode = "Idle_S"
	

func _unhandled_input(event):
	if event.is_action_pressed("Click"):
		moving = true
		destination = get_global_mouse_position()	
	if (event.is_action_pressed("ui_select")):
		moving = false
		
func _process(delta):
	#var velocity := Vector2()  # The player's movement vector.
	AnimationLoop()
	SkillLoop()  
	
func _physics_process(delta):
	MovementLoop(delta)
	
func MovementLoop(delta):
	
	if moving == false:      #function to walk hero by click 
		speed = 0
	else:
		speed += acceleration * delta
		if speed > max_speed:
			speed = max_speed
	movement = position.direction_to(destination) * speed
	move_direction = rad2deg(destination.angle_to_point(position))
	if position.distance_to(destination) > 5:
		movement = move_and_slide(movement)
	else:
		moving = false

func SkillLoop():
	if Input.is_action_just_pressed("Shoot") and can_fire == true:
		can_fire = false
		shooting = true
		speed = 0
		moving = false
		fire_direction = (get_angle_to(get_global_mouse_position())/3.14)*180
		get_node("TurnAxis").rotation = get_angle_to(get_global_mouse_position())
		match DataImport.skill_data[selected_skill].SkillType:
			"MeleeAttack":
				melee = true
				damage = DataImport.skill_data[selected_skill].SkillDamage
		yield(get_tree().create_timer(rate_of_fire), "timeout")
		can_fire = true
		shooting = false
		melee = false
		speed = 140
		
		
func AnimationLoop():  #function for setting the appropriate animation of the player
		
	if shooting == true:
		anim_mode = "Attack"
		if fire_direction <= 15 and fire_direction >= -15:
			anim_direction = "E"
		elif fire_direction <= 60 and fire_direction >= 15:
			anim_direction = "SE"
		elif fire_direction <= 120 and fire_direction >= 60:
			anim_direction = "S"
		elif fire_direction <= 165 and fire_direction >= 120:
			anim_direction = "SW"
		elif fire_direction >= -60 and fire_direction<= -15:
			anim_direction = "NE" 
		elif fire_direction >= -120 and fire_direction <= -60:
			anim_direction = "N"
		elif fire_direction >= -165 and fire_direction <= -120:
			anim_direction = "NW"
		elif fire_direction <= -165 or fire_direction >= 165:
			anim_direction = "W"
			
	else:
		if shooting == false:
			anim_direction = "S"
			if move_direction <= 15 and move_direction >= -15:
				anim_direction = "E"
			elif move_direction <= 60 and move_direction >= 15:
				anim_direction = "SE"
			elif move_direction <= 120 and move_direction >= 60:
				anim_direction = "S"
			elif move_direction <= 165 and move_direction >= 120:
				anim_direction = "SW"
			elif move_direction >= -60 and move_direction <= -15:
				anim_direction = "NE" 
			elif move_direction >= -120 and move_direction <= -60:
				anim_direction = "N"
			elif move_direction >= -165 and move_direction <= -120:
				anim_direction = "NW"
			elif move_direction <= -165 or move_direction >= 165:
				anim_direction = "W"
			
		
		if moving == true:
			anim_mode = "Walk"
		else: 
			anim_mode = "Idle"
		
	animation = anim_mode + "_" + anim_direction
	get_node("AnimationPlayer").play(animation)
	#print(animation)
		
func stop_player():
	moving = false

func _on_MelleRange_body_entered(body):
	if body.is_in_group("Enemies"):
		if((get_angle_to(body.position)/3.14)*180) <= (fire_direction +25) and ((get_angle_to(body.position)/3.14)*180) >= (fire_direction - 25):
				body.OnHit(damage)
