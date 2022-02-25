extends Spatial


# Declare member variables here. Examples:
var max_x: int = 50
var max_y: int = 50
var max_z: int = 50
export (PackedScene) var target_scene: PackedScene

var rng = RandomNumberGenerator.new()
# Called when the node enters the scene tree for the first time.
func _ready():
	for i in range(1000):
		var a = target_scene.instance()
		a.pos_bound = 20
		a.pos_min = 0
		a.rot_bound = 0.5
		a.speed_bound = 0.1
		a.transform.origin.x = rng.randf_range(-max_x, max_x)
		a.transform.origin.y = rng.randf_range(-max_y, max_y)
		a.transform.origin.z = rng.randf_range(-max_z, max_z)
		a.scale_ = 1
		add_child(a)
	for i in range(35):
		var a = target_scene.instance()
		a.pos_bound = 100
		a.pos_min = 300
		a.rot_bound = 0.2
		a.speed_bound = 0.04
		a.scale_ = 70
		add_child(a)
	for i in range(3):
		var a = target_scene.instance()
		a.pos_bound = 200
		a.pos_min = 700
		a.rot_bound = 0.01
		a.speed_bound = 0#20
		a.scale_ = 500
		a.transform.origin.x = 10
		add_child(a)


# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass
