extends Area

signal destroyed

onready var animation_player : AnimationPlayer = $AnimationPlayer
func _ready():
	$AnimationPlayer.stop()
	
func destroy() -> void:
	animation_player.play("destroy")

func _on_AnimationPlayer_animation_finished(anim_name):
	if anim_name == "destroy":
		emit_signal("destroyed")
