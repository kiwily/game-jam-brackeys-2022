extends Spatial

signal destroyed
signal destroy

var object : Spatial

# Velocities on rayons
var velocities : Vector3

# Rotation velocities
var rotation_velocities : Vector3

var prouf_sound = preload("res://assets/audio/wov.wav")

func _ready() -> void:
	set_process(false)

func init_object_movement(rayons : Vector3, new_velocities : Vector3, new_rotation_velocities : Vector3, start_with_random_angle: bool) -> void:
	# Rayons	
	object.translate(rayons)
	
	# Random initial deplacement
	if start_with_random_angle:
		var v : Vector3 = new_velocities.normalized()
		rotate_x(v.x * randf() * 1000)
		rotate_y(v.y * randf() * 1000)
		rotate_z(v.z * randf() * 1000)
	
	# Set velocities
	velocities = new_velocities
	rotation_velocities = new_rotation_velocities
	
	set_process(true)

func _process(delta):
	# Move object around a elliptic trajectory
	rotate_x(velocities.x * delta)
	rotate_y(velocities.y * delta)
	rotate_z(velocities.z * delta)
	
	# Rotate object
	object.rotate_x(rotation_velocities.x * delta)
	object.rotate_y(rotation_velocities.y * delta)
	object.rotate_z(rotation_velocities.z * delta)

func _on_Object_Destroy():
	emit_signal("destroy")
	$Sound.stream = prouf_sound
	$Sound.play()

func _on_Object_Destroyed():
	emit_signal("destroyed")
	queue_free()

