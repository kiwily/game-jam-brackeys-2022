extends Area

signal destroyed

onready var animation_player : AnimationPlayer = $AnimationPlayer

func destroy() -> void:
	animation_player.play("destroy")

func _on_AnimationPlayer_animation_finished(anim_name):
	if anim_name == "destroyed":
		emit_signal("destroyed")
