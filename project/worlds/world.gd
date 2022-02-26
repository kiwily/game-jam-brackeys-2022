extends Spatial

export (PackedScene) var arrow_scene : PackedScene

onready var player : KinematicBody = $Player
onready var reals : Spatial = $Reals
onready var unreals : Spatial = $Unreals
onready var arrows : Spatial = $Arrows

func _ready():
	# Connect all real signal
	for child in reals.get_children():
		for target in child.get_children():
			target.connect("destroyed", self, "_on_Target_destroyed")
			target.connect("destroy", self, "_on_Target_destroy")
	# Connect all unreal signal
	if reals.get_child_count() > 0:
		for child in unreals.get_children():
			for target in child.get_children():
				target.connect("destroy", self, "_on_Unreal_Target_destroy", [target])
	# Animation
	player.enter_world()
	
func _process(_delta):
	pass
#	var player_to_target : Vector3 = (target.global_transform.origin - player.global_transform.origin).normalized()
#	var player_direction : Vector3 = - player.camera.global_transform.basis.z.normalized()
		
#	var dot : float = player_direction.dot(player_to_target)
#	audio_stream_player.pitch_scale = 2 - dot


func _on_Target_destroy():
	player.exit_world()
	
func _on_Unreal_Target_destroy(node : Spatial) -> void:
	var i_real : int = randi() % reals.get_child_count()
	if reals.get_child(i_real).get_child_count() == 0:
		return
	var j_real : int = randi() % reals.get_child(i_real).get_child_count()
	var selected_target_position : Vector3 = reals.get_child(i_real).get_child(j_real).object.global_transform.origin
	var arrow : Spatial = arrow_scene.instance()
	arrows.add_child(arrow)
	
	arrow.global_transform.origin = node.object.global_transform.origin
	arrow.transform.basis.y = (selected_target_position - arrow.global_transform.origin).normalized()
	arrow.transform.basis.x = Vector3(-arrow.transform.basis.y.y, arrow.transform.basis.y.x, 0).normalized()
	arrow.transform.basis.z = arrow.transform.basis.x.cross(arrow.transform.basis.y).normalized()

func _on_Target_destroyed():
	if WorldManager.has_next_world():
		WorldManager.goto_next_world()
	else:
		print("Game Finish")
