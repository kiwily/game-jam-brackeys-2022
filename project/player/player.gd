extends KinematicBody

signal world_entered
signal world_exited

export (float) var max_forward_speed : float = 10
export (float) var rotation_speed : float = 10
export (float) var acceleration : float = 10
export (float) var deceleration : float = 10
export (float) var mouse_sensitivity : float = 0.1

onready var animation_player_world : AnimationPlayer = $AnimationPlayerWorld
onready var animation_player_crosshair : AnimationPlayer = $AnimationPlayerCrosshair


var velocity : Vector3 = Vector3()
var direction : Vector3 = Vector3()

onready var camera : Camera = $Camera
onready var raycast : RayCast = $RayCast

var raycast_collider : Object
var is_crosshair_locked : bool = false

func _ready():
	Input.set_mouse_mode(Input.MOUSE_MODE_CAPTURED)
	
func _process(delta) -> void:
	process_raycast()
	process_input()
	process_movement(delta)
	
func process_raycast() -> void:
	raycast_collider = null
	if raycast.is_colliding():
		raycast_collider = raycast.get_collider()
		if not is_crosshair_locked:
			animation_player_crosshair.play("lock-in")
			is_crosshair_locked = true
	else:
		if is_crosshair_locked:
			animation_player_crosshair.play("lock-out")
			is_crosshair_locked = false
		
	
func process_input() -> void:
	direction = Vector3()
	var input_movement_vector : Vector2 = Vector2()
	
	# Check action
	if Input.is_action_just_pressed("check"):
		if raycast_collider:
			if raycast_collider.has_method("destroy"):
				raycast_collider.destroy()
	
	if Input.is_action_pressed("forward"):
		input_movement_vector.y += 1
	if Input.is_action_pressed("backwards"):
		input_movement_vector.y -= 1
	if Input.is_action_pressed("right"):
		input_movement_vector.x += 1
	if Input.is_action_pressed("left"):
		input_movement_vector.x -= 1
	input_movement_vector = input_movement_vector.normalized()
	
	direction += - global_transform.basis.z * input_movement_vector.y
	direction += global_transform.basis.x * input_movement_vector.x
	
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
	if event is InputEventMouseMotion and Input.get_mouse_mode() == Input.MOUSE_MODE_CAPTURED:
		rotate_object_local(Vector3(0, 1, 0), deg2rad(event.relative.x * mouse_sensitivity * -1))
		rotate_object_local(Vector3(1, 0, 0), deg2rad(event.relative.y * mouse_sensitivity * -1))

func enter_world():
	animation_player_world.play("world-in")

func exit_world():
	animation_player_world.play("world-out")

func _on_AnimationPlayerWorld_animation_finished(anim_name):
	if anim_name == "world-in":
		emit_signal("world_entered")
	elif anim_name == "world-out":
		emit_signal("world_exited")
