extends Actor
#variables for the different movement types of the player including double jump and dash
@export var acceleration: float
@export var ground_friction: float
@export var air_friction: float
const DASH_SPEED = 2.5
@export var deaths = 0

var dashing = false
 
var can_double_jump := true

 #Determining whether the player is on the ground or not to enable double jump
func _physics_process(delta: float) -> void:
	# Status
	if not is_on_floor():
		velocity.y += gravity * delta
	else:
		can_double_jump = true
 
	# Handle Jump.
	if Input.is_action_just_pressed("jump"):
		
		# Ground jump
		if is_on_floor():
			velocity.y = -abs(jump_velocity)
		else:
			if can_double_jump:
				velocity.y = -abs(jump_velocity)
				can_double_jump = false
 
	# Jump cancel
	if Input.is_action_just_released("jump") and not is_on_floor() and velocity.y < 0:
		velocity.y *= 0.25
 
	# Determining what direction the player wants to move in based on input using the keybaord also controlling the sprite of the player to change based on direction the character is facing
	var direction := Input.get_axis("left", "right")
	if Input.is_action_just_pressed("dash"):
		if !dashing and direction:
			start_dash()
	if direction:
		if dashing:
			velocity.x = max_speed * DASH_SPEED * direction
		else:
			velocity.x = lerp(velocity.x, direction * max_speed, acceleration)
			Walking.play_sfx()
		if direction > 0:
			$Sprite2D.flip_h = true
			$DashParticles.gravity.x = -2000
		elif direction < 0:
			$Sprite2D.flip_h = false
			$DashParticles.gravity.x = 2000
	else:
		if is_on_floor():
			velocity.x = lerp(velocity.x, 0.0, ground_friction)
			Walking.play_sfx()
		else:
			velocity.x = lerp(velocity.x, 0.0, air_friction)
			
 
	# Controlling the different animations of the player based on different situations
	if is_on_floor():
		if direction:
			$AnimationPlayer.play("walk")
		else:
			$AnimationPlayer.play("idle")
	else:
		$AnimationPlayer.play("aerial")
 
	move_and_slide()


#Resetting the player if touching spikes
func die() -> void:
	get_tree().reload_current_scene()
	deaths += 1
	print(deaths)
#Starts the dash movement increasing the speed of the player for a limited time
func start_dash():
	dashing = true
	$DashTimer.connect("timeout", stop_dash)
	$DashTimer.start()
	$DashParticles.emitting = true
#Stops the dash after the timer ends decreasing the speed back to original speed
func stop_dash():
	dashing = false
	$DashParticles.emitting = false
