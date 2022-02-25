extends Node

var loader : ResourceInteractiveLoader

func goto_scene(path : String) -> void:
	loader = ResourceLoader.load_interactive(path)
	if loader == null:
		print("[Error] Loader is not defined, path is: %s" % path)
		return
	set_process(true)
	
func _process(_delta):
	if loader == null:
		set_process(false)
		return
	
	var err : int = loader.poll()
	
	if err == ERR_FILE_EOF: # Finished loading
		var resource : Resource = loader.get_resource()
		loader = null
		WorldManager.change_world(resource)
	elif err == OK:
		print('Scene is loading ...')
	else:
		print('[Error] Loader returns %d' % err)
		loader = null
