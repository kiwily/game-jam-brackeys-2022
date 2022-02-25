extends Spatial

signal succeeded

onready var player : KinematicBody = $Player
onready var reals : Spatial = $Reals

onready var audio_stream_player : AudioStreamPlayer = $AudioStreamPlayer


func _ready():
	# Connect all real signal
	for child in reals.get_children():
		for target in child.get_children():
			target.connect("destroyed", self, "_on_Target_destroyed")

func _process(_delta):
	pass
#	var player_to_target : Vector3 = (target.global_transform.origin - player.global_transform.origin).normalized()
#	var player_direction : Vector3 = - player.camera.global_transform.basis.z.normalized()
		
#	var dot : float = player_direction.dot(player_to_target)
#	audio_stream_player.pitch_scale = 2 - dot


func _on_Target_destroyed():
	set_process(false)
	emit_signal("succeeded")
	print("Succeeded")
	if WorldManager.has_next_world():
		WorldManager.goto_next_world()
	else:
		print("Game Finish")
