extends Spatial

var object : Spatial

# Velocities on rayons
var velocities : Vector3

# Rotation velocities
var rotation_velocities : Vector3

func _ready() -> void:
	set_process(false)

func init_object_movement(rayons : Vector3, new_velocities : Vector3, new_rotation_velocities : Vector3) -> void:
	# Rayons	
	object.translate(rayons)
	
	# Random initial deplacement
	rotate_x(rand_range(0, 2 * PI))
	rotate_y(rand_range(0, 2 * PI))
	rotate_z(rand_range(0, 2 * PI))
	
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

func _on_Race_destroyed():
	queue_free()
