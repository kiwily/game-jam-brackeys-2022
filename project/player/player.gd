extends KinematicBody


export (float) var max_forward_speed : float = 10
export (float) var rotation_speed : float = 10
export (float) var acceleration : float = 10
export (float) var deceleration : float = 10
export (float) var mouse_sensitivity : float = 0.1


var velocity : Vector3 = Vector3()
var direction : Vector3 = Vector3()

onready var camera : Camera = $Camera
onready var raycast : RayCast = $RayCast

func _ready():
	Input.set_mouse_mode(Input.MOUSE_MODE_CAPTURED)
	

func _process(delta) -> void:
	process_input()
	process_movement(delta)
	
func process_input() -> void:
	direction = Vector3()
	var input_movement_vector : Vector2 = Vector2()
	
	if Input.is_action_pressed("forward"):
		input_movement_vector.y += 1
	if Input.is_action_pressed("backwards"):
		input_movement_vector.y -= 1
	if Input.is_action_pressed("right"):
		input_movement_vector.x += 1
	if Input.is_action_pressed("left"):
		input_movement_vector.x -= 1
	input_movement_vector = input_movement_vector.normalized()
	
	var camera_xform : Transform = camera.global_transform
	direction += - camera_xform.basis.z * input_movement_vector.y
	direction += camera_xform.basis.x * input_movement_vector.x
	
	if Input.is_action_just_pressed("ui_cancel"):
		if Input.get_mouse_mode() == Input.MOUSE_MODE_VISIBLE:
			Input.set_mouse_mode(Input.MOUSE_MODE_CAPTURED)
		else:
			Input.set_mouse_mode(Input.MOUSE_MODE_VISIBLE)
	
func process_movement(delta) -> void:
	direction = direction.normalized()
	
	var target : Vector3 = direction * max_forward_speed
	
	var current_acceleration : float
	if direction.dot(velocity) > 0:
		current_acceleration = acceleration
	else:
		current_acceleration = deceleration
		
	velocity = velocity.linear_interpolate(target, current_acceleration * delta)
	velocity = move_and_slide(velocity)
	
	
func _input(event):
	if Input.is_action_just_pressed("check"):
		raycast.force_raycast_update()
		if raycast.is_colliding():
			var collider : Object = raycast.get_collider()
			if collider.has_method("destroy"):
				collider.destroy()
		
	if event is InputEventMouseMotion and Input.get_mouse_mode() == Input.MOUSE_MODE_CAPTURED:
		camera.rotate_x(deg2rad(event.relative.y * mouse_sensitivity * -1))
		rotate_y(deg2rad(event.relative.x * mouse_sensitivity * -1))
		var camera_rot : Vector3 = camera.rotation_degrees
		camera_rot.x = clamp(camera_rot.x, -70, 70)
		camera.rotation_degrees = camera_rot

