extends Spatial

onready var player : KinematicBody = $Player
onready var target : Area = $Target

onready var audio_stream_player : AudioStreamPlayer = $AudioStreamPlayer

func _process(delta):
	var player_to_target : Vector3 = (target.global_transform.origin - player.global_transform.origin).normalized()
	var player_direction : Vector3 = - player.camera.global_transform.basis.z.normalized()
	
	var dot : float = player_direction.dot(player_to_target)
	audio_stream_player.pitch_scale = 2 - dot