extends KinematicBody

onready var Camera = $Pivot/Camera

var gravity = 0
var max_speed = 8
var mouse_sensitivity = 0.002
var mouse_range = 1.2
var mouse_locked := true

var dead := false

var velocity = Vector3()

func _ready():
	Input.set_mouse_mode(Input.MOUSE_MODE_CAPTURED)



func get_input():
	var input_dir = Vector3()
	if Input.is_action_just_pressed("toggle_mouse_lock"): # just for debug
		mouse_locked = not mouse_locked
		if mouse_locked: Input.set_mouse_mode(Input.MOUSE_MODE_CAPTURED)
		else: Input.set_mouse_mode(Input.MOUSE_MODE_VISIBLE)
	
	if not dead:
		if Input.is_action_pressed("forward"):
			input_dir += -Camera.global_transform.basis.z
		if Input.is_action_pressed("back"):
			input_dir += Camera.global_transform.basis.z
		if Input.is_action_pressed("left"):
			input_dir += -Camera.global_transform.basis.x
		if Input.is_action_pressed("right"):
			input_dir += Camera.global_transform.basis.x
	input_dir = input_dir.normalized()
	return input_dir

func _unhandled_input(event):
	if mouse_locked and event is InputEventMouseMotion:
		$Pivot.rotate_x(-event.relative.y * mouse_sensitivity)
		rotate_y(-event.relative.x * mouse_sensitivity)
		$Pivot.rotation.x = clamp($Pivot.rotation.x, -mouse_range, mouse_range)

func _physics_process(delta):
	velocity.y += gravity * delta
	var desired_velocity = get_input() * max_speed
	
	velocity.x = desired_velocity.x
	velocity.z = desired_velocity.z
	velocity = move_and_slide(velocity, Vector3.UP, true)
