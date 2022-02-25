extends Spatial

export (PackedScene) var object_scene : PackedScene
export (float) var object_scale : float = 1

export (int) var number_of_target : int = 1000

export (Vector3) var maximum_spawn_distance : Vector3 = Vector3(50, 50, 50)

export (Vector3) var minimum_rayon : Vector3 = Vector3(0, 0, 0)
export (Vector3) var maximum_rayon : Vector3 = Vector3(20, 20, 20)

export (float) var maximum_rotation_velocity : float = .5
export (float) var maximum_velocity : float = .1

export (PackedScene) var target_scene: PackedScene

var rng = RandomNumberGenerator.new()

func _ready():
	for i in range(number_of_target):
		add_target_at_random()

func add_target_at_random() -> void:
	var target : Spatial = target_scene.instance()
	# Translate target
	target.translate(Vector3(
		rand_range(-maximum_spawn_distance.x, maximum_spawn_distance.x),
		rand_range(-maximum_spawn_distance.y, maximum_spawn_distance.y),
		rand_range(-maximum_spawn_distance.z, maximum_spawn_distance.z)
	))
	# Target rayons
	var target_rayons : Vector3 = Vector3(
		rand_range(minimum_rayon.x, maximum_rayon.x),
		rand_range(minimum_rayon.y, maximum_rayon.y),
		rand_range(minimum_rayon.z, maximum_rayon.z)
	)
	
	# Velocity
	var target_velocities : Vector3 = Vector3(
		atan(maximum_velocity * rng.randfn() / (1 + target_rayons.x)),
		atan(maximum_velocity * rng.randfn() / (1 + target_rayons.y)),
		atan(maximum_velocity * rng.randfn() / (1 + target_rayons.z))
	)

	var target_rotation_velocities : Vector3 = Vector3(
		maximum_rotation_velocity * rng.randfn(),
		maximum_rotation_velocity * rng.randfn(),
		maximum_rotation_velocity * rng.randfn()
	)

	add_child(target)
	
	target.object = object_scene.instance()
	target.add_child(target.object)
	
	target.init_object_movement(target_rayons, target_velocities, target_rotation_velocities)
	target.object.global_scale(Vector3(object_scale, object_scale, object_scale))
