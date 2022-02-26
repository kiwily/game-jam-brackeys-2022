extends Node2D

func _on_Button_pressed():
	$ViewportContainer/Viewport/Control.hide()
	Input.set_mouse_mode(Input.MOUSE_MODE_CAPTURED)
