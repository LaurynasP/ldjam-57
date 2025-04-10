extends Node
class_name LoadingScreen

var loadables: Array[PackedScene]

var currently_loading_index := -1

var progress: Array[int] = []

func init(scenes: Array[PackedScene]):
	loadables = scenes
	process_mode = Node.PROCESS_MODE_ALWAYS

func _process(_delta: float):
	if progress.size() == 0:
		try_load_next_scene()
	else:
		if not scene_loading_finished():
			return
		
		instantiate_loaded_scene()
		
		if try_load_next_scene():
			return
		else:
			self.queue_free()

func instantiate_loaded_scene():	
	var scene = ResourceLoader.load_threaded_get(loadables[currently_loading_index].resource_path)

	var instance = scene.instantiate()

	LoadingManager.level_host.add_child(instance)
	
	return true
	
func scene_loading_finished():
	var result = ResourceLoader.load_threaded_get_status(loadables[currently_loading_index].resource_path, progress)
	
	return result == ResourceLoader.ThreadLoadStatus.THREAD_LOAD_LOADED

func try_load_next_scene():
	currently_loading_index += 1

	if currently_loading_index >= loadables.size():
		return false
	
	ResourceLoader.load_threaded_request(loadables[currently_loading_index].resource_path)

	ResourceLoader.load_threaded_get_status(loadables[currently_loading_index].resource_path, progress)

	return true
