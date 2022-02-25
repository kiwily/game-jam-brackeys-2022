extends Area

signal destroy
signal destroyed

onready var animation_player : AnimationPlayer = $AnimationPlayer

func destroy() -> void:
	emit_signal("destroy")
	animation_player.play("destroy")

func _on_AnimationPlayer_animation_finished(anim_name):
	if anim_name == "destroy":
		emit_signal("destroyed")
