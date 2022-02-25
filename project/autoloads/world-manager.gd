extends Node

var world_container : Node2D

var current_world : int = 1
var number_of_world : int = 4

func _ready():
	world_container = get_tree().get_current_scene()

func get_world_path(world_index : int) -> String:
	return "res://worlds/world-%d/world.tscn" % world_index

func has_next_world():
	if current_world < number_of_world:
		return true
	return false

func goto_next_world():
	current_world += 1
	SceneManager.goto_scene(get_world_path(current_world))
	
func change_world(new_world_resource : Resource):
	var world_viewport : Viewport = world_container.get_node("ViewportContainer/Viewport")
	for node in world_viewport.get_children():
		world_viewport.remove_child(node)
		node.queue_free()
	world_viewport.add_child(new_world_resource.instance())
