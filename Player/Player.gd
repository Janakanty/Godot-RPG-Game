extends KinematicBody2D

export var speed = 0  # How fast the player will move (pixels/sec).
var max_speed = 200
var acceleration = 1299
var move_direction 
var moving = false
var destination = Vector2()
var movement = Vector2()
var screen_size  # Size of the game window.

func _unhandled_input(event):
	if event.is_action_pressed("Click"):
		moving = true
		destination = get_global_mouse_position()	
	if (event.is_action_pressed("ui_select")):
		moving = false
		
func _process(delta):
	var velocity := Vector2()  # The player's movement vector.
	AnimationLoop()
	
func _physics_process(delta):
	MovementLoop(delta)
	
func MovementLoop(delta):
	if moving == false:
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


func AnimationLoop():
	var anim_direction = "S"
	var anim_mode = "Idle"
	var animation
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
		$AnimatedSprite.play(anim_direction)
	elif moving == false:
		$AnimatedSprite.play(anim_mode)
	
func stop_player():
	moving = false
	


