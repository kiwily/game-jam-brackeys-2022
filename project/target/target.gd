extends Spatial

var rng = RandomNumberGenerator.new()

# Declare member variables here. Examples:

onready var object : Spatial = $Race
var speed_x
var speed_y
var speed_z

var rot_x
var rot_y
var rot_z

# Called when the node enters the scene tree for the first time.
func _ready():
	rng.randomize()
	var my_random_number = rng.randf_range(-10.0, 10.0)
	
	object.transform.origin.x = rng.randf_range(-20.0, 20.0)
	object.transform.origin.y = rng.randf_range(-20.0, 20.0)
	object.transform.origin.z = rng.randf_range(-20.0, 20.0)
	
	speed_x = rng.randf_range(-2.0, 2.0)
	speed_y = rng.randf_range(-2.0, 2.0)
	speed_z = rng.randf_range(-2.0, 2.0)
	
	rot_x = rng.randf_range(-2.0, 2.0)
	rot_y = rng.randf_range(-2.0, 2.0)
	rot_z = rng.randf_range(-2.0, 2.0)


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	rotate_x(speed_x*delta)
	rotate_y(speed_y*delta)
	rotate_z(speed_z*delta)
	
	object.rotate_x(rot_x)
	object.rotate_y(rot_y)
	object.rotate_z(rot_z)
