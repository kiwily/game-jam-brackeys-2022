extends Spatial


# Declare member variables here. Examples:
var max_x: int = 50
var max_y: int = 50
export (PackedScene) var target_scene: PackedScene

var rng = RandomNumberGenerator.new()
# Called when the node enters the scene tree for the first time.
func _ready():
	#for i in range(1000):
	#	var a = target_scene.instance()
	#	a.pos_bound = 20
	#	a.pos_min = 0
	#a.rot_bound = 0.5
	#	a.speed_bound = 0.1
	#	a.transform.origin.x = rng.randf_range(-max_x, max_x)
	#	a.transform.origin.y = rng.randf_range(-max_y, max_y)
	#	add_child(a)
	for i in range(100):
		var a = target_scene.instance()
		a.pos_bound = 20
		a.pos_min = 100
		a.rot_bound = 0.2
		a.speed_bound = 0.04
		a.global_scale(Vector3(5, 5, 5))
		add_child(a)
	#for i in range(10):
#		var a = target_scene.instance()
#		a.pos_bound = 20
#		a.pos_min = 3000
#		a.rot_bound = 0.5
#		a.speed_bound = 0.05
#		a.global_scale(Vector3(50, 50, 50))
#		add_child(a)


# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass
