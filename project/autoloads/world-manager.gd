extends Node

var final_viewport : Viewport

var current_world : int = 1
var number_of_world : int = 6

func _ready():
	final_viewport = get_tree().get_current_scene().get_node("ViewportContainerSobol/Viewport")

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
	for node in final_viewport.get_children():
		final_viewport.remove_child(node)
		node.queue_free()
	final_viewport.add_child(new_world_resource.instance())
