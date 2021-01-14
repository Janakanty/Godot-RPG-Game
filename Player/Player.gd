extends KinematicBody2D

export var speed = 0  # How fast the player will move (pixels/sec).
var max_speed = 140
var acceleration = 1299
var move_direction 
var moving = false
var destination = Vector2()
var movement = Vector2()
var screen_size  # Size of the game window.

var selected_skill
var can_fire = true
var shooting = false
var melee = false
var damage
var fire_direction
var rate_of_fire = 0.4

var anim_direction = "S"
var anim_mode = "Idle"
	

func _unhandled_input(event):
	if event.is_action_pressed("Click"):
		moving = true
		destination = get_global_mouse_position()	
	if (event.is_action_pressed("ui_select")):
		moving = false
		
func _process(delta):
	var velocity := Vector2()  # The player's movement vector.
	AnimationLoop()
	SkillLoop()  
	
func _physics_process(delta):
	MovementLoop(delta)
	
func MovementLoop(delta):
	var left = Input.is_action_pressed("ui_left")
	var right = Input.is_action_pressed("ui_right")
	var up = Input.is_action_pressed("ui_up")
	var down = Input.is_action_pressed("ui_down")
	
	move_direction.x = -int(left) + int(right)
	move_direction.y = -int(up) + int(down)
	
	var motion = move_direction.normalized() + speed
	move_and_slide(motion, Vector2(0, 0))
	
	
	#if moving == false:      //function to walk hero by click (disabled)
	#	speed = 0
	#else:
	#	speed += acceleration * delta
	#	if speed > max_speed:
	#		speed = max_speed
	#movement = position.direction_to(destination) * speed
	#move_direction = rad2deg(destination.angle_to_point(position))
	#if position.distance_to(destination) > 5:
	#	movement = move_and_slide(movement)
	#else:
	#	moving = false

func SkillLoop():
	if Input.is_action_just_pressed("Shoot") and can_fire == true:
		can_fire = false
		shooting = true
		moving = false
		get_node("TurnAxis").rotation = get_angle_to(get_global_mouse_position()/3.14)*180
		#match DataImport.skill_data[selected_skill].SkillType:
	
			#"MeleeAttack":
			#	melee = true
			#	damage = DataImport.skill_data[slected_skill].SkillDamage
		yield(get_tree().create_timer(rate_of_fire), "timeout")
		can_fire = true
		shooting = false
		melee = false
		speed = 140
		
		
func AnimationLoop():  #function for setting the appropriate animation of the player
	
	match move_direction:
		Vector2(-1,0):
			anim_direction = "W"
		Vector2(-1,0):
			anim_direction = "E"
		Vector2(-1,0):
			anim_direction = "S"
		Vector2(-1,0):
			anim_direction = "N"
		Vector2(-1,0):
			anim_direction = "NW"
		Vector2(-1,0):
			anim_direction = "SW"
		Vector2(-1,0):
			anim_direction = "NE"
		Vector2(-1,0):
			anim_direction = "SE"
		
	if move_direction != Vector2(0,0):
		anim_mode = "Walk"
	else:
		anim_mode = "Idle"
		
	animation = anim_mode + "_" anim_direction
	get_node("AnimationPlayer").play(animation)
		
	
	#if shooting == true:
	#	if anim_direction == "SW" or "S" or "W":
	#		get_node("AnimationPlayer").play("Attack_SW")
	#	elif anim_direction == "SE" or "E":
	#		get_node("AnimationPlayer").play("Attack_SE")
	#else:
	#	if move_direction <= 15 and move_direction >= -15:
	#		anim_direction = "E"
	#		anim_mode = "Idle"
	#	elif move_direction <= 60 and move_direction >= 15:
	#		anim_direction = "SE"
	#		anim_mode = "Idle"
	#	elif move_direction <= 120 and move_direction >= 60:
	#		anim_direction = "S"
	#		anim_mode = "Idle"
	#	elif move_direction <= 165 and move_direction >= 120:
	#		anim_direction = "SW"
	#		anim_mode = "Idle2"
	#	elif move_direction >= -60 and move_direction <= -15:
	#		anim_direction = "NE"
	#		anim_mode = "Idle_N"
	#	elif move_direction >= -120 and move_direction <= -60:
	#		anim_direction = "N"
	#		anim_mode = "Idle_N"
	#	elif move_direction >= -165 and move_direction <= -120:
	#		anim_direction = "NW"
	#		anim_mode = "Idle_N2"
	#	elif move_direction <= -165 or move_direction >= 165:
	#		anim_direction = "W"
	#		anim_mode = "Idle2"
	#	
	#if moving == true:
	#	$AnimatedSprite.play(anim_direction)
	#elif moving == false:
	#	$AnimatedSprite.play(anim_mode)
	
func stop_player():
	moving = false
	


