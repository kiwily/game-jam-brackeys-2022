extends Spatial

var rng = RandomNumberGenerator.new()

# Declare member variables here. Examples:

onready var object : Spatial = $Race

export (float) var speed_bound: float
export (float) var pos_min: float
export (float) var pos_bound: float
export (float) var rot_bound: float
export (int) var scale_: int

var speed_x
var speed_y
var speed_z

var pos_x
var pos_y
var pos_z

var rot_x
var rot_y
var rot_z

# Called when the node enters the scene tree for the first time.
func _ready():
	rng.randomize()
	pos_x = pos_min + pos_bound * rng.randfn()
	pos_y = pos_min + pos_bound * rng.randfn()
	pos_z = pos_min + pos_bound * rng.randfn()
	
	object.transform.origin.x = pos_x
	object.transform.origin.y = pos_y
	object.transform.origin.z = pos_z
	
	object.global_scale(Vector3(scale_, scale_, scale_))
	
	rotate_x(rng.randf_range(0, 2 * PI))
	rotate_y(rng.randf_range(0, 2 * PI))
	rotate_z(rng.randf_range(0, 2 * PI))
	
	speed_x = atan(speed_bound * rng.randfn() / (1 + pos_x))
	speed_y = atan(speed_bound * rng.randfn() / (1 + pos_y))
	speed_z = atan(speed_bound * rng.randfn() / (1 + pos_z))
	
	rot_x = rot_bound * rng.randfn()
	rot_y = rot_bound * rng.randfn()
	rot_z = rot_bound * rng.randfn()


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	rotate_x(speed_x*delta)
	rotate_y(speed_y*delta)
	rotate_z(speed_z*delta)
	
	object.rotate_x(rot_x*delta)
	object.rotate_y(rot_y*delta)
	object.rotate_z(rot_z*delta)
