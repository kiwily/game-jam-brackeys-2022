extends Spatial

func _on_Timer_timeout():
	print('Time out: ', name)
	$ArrowMesh/AnimationPlayer.play("fade")


func _on_AnimationPlayer_animation_finished(anim_name):
	queue_free()
