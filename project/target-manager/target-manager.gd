extends Spatial


# Declare member variables here. Examples:
# var a = 2
# var b = "text"
export (PackedScene) var target_scene: PackedScene

# Called when the node enters the scene tree for the first time.
func _ready():
	for i in range(10):
		var a = target_scene.instance()
		add_child(a)


# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass
