extends Node

var current_world : int = 1
var number_of_world : int = 6

func get_world_path(world_index : int) -> String:
	return "res://worlds/world-%d/world.tscn" % world_index

func has_next_world():
	if current_world < number_of_world:
		return true
	return false

func goto_next_world():
	current_world += 1
	SceneManager.goto_scene(get_world_path(current_world))
	
	
