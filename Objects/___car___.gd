extends VehicleBody3D

@export var max_speed := 200.0
@export var brake_power := 100.0
@export var acceleration := 20.0
@export var deceleration := 45.0
@export var steering_max := 90.0
@export var steering_speed := 0.05
@export var steering_stop := 0.1
var current_speed := 0.0
var current_steering := 0.0


# Called when the node enters the scene tree for the first time.
func _ready():
	set_center_of_mass($CoM.position)


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	# Moves the car forward
	if Input.is_action_pressed("forward"):
		if get_engine_force() <= max_speed:
			current_speed += acceleration
			set_engine_force(current_speed)
	if Input.is_action_pressed("backward"):
		if get_engine_force() >= -max_speed:
			current_speed -= acceleration
			set_engine_force(current_speed)
			
	# Slows the car down when nothing is pressed
	if get_engine_force() != 0 and Input.is_action_pressed("forward") == false and Input.is_action_pressed("backward") == false:
		if get_engine_force() > 0:
			current_speed -= deceleration
			set_engine_force(current_speed)
		else:
			current_speed += deceleration
			set_engine_force(current_speed)
			
	# Adds a 'brake' function, which stops the car faster
	if Input.is_action_pressed("brake"):
		if current_speed > 0:
			current_speed -= brake_power
			set_engine_force(current_speed)
		if current_speed < 0:
			current_speed += brake_power
			set_engine_force(current_speed)
		else:
			pass
	
	# Steers the car left or right, and stops steering if nothing is pressed
	if Input.is_action_pressed("left"):
		set_steering(0.5)
	if Input.is_action_pressed("right"):
		set_steering(-0.5)
	if Input.is_action_just_released("left") or Input.is_action_just_released("right"):
		set_steering(0)
	
		
	#print("max speed is ", max_speed)
	#print("steering is ", current_steering)
