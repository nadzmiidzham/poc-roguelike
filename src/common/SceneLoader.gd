class_name SceneLoader
extends Node


signal on_start_load(max_value)
signal on_update_load(value)
signal on_finish_load()

onready var thread = null


func _start_load(path: String):
	var resource_loader = ResourceLoader.load_interactive(path)
	var resource = null

	emit_signal("on_start_load", resource_loader.get_stage_count())

	while true:
		emit_signal("on_update_load", resource_loader.get_stage())

		var err = resource_loader.poll()
		if err == ERR_FILE_EOF: # load operation has completed successfully
			resource = resource_loader.get_resource()
			break
		elif err != OK:
			print("An error has occured during loading")
			break

	call_deferred("_finish_load", resource)

func _finish_load(resource: PackedScene):
	thread.wait_to_finish()

	# change scene
	var next_scene = resource.instance()
	get_tree().current_scene.queue_free()
	get_tree().root.add_child(next_scene)
	get_tree().current_scene = next_scene

	emit_signal("on_finish_load")


func load_scene(path: String):
	thread = Thread.new()
	thread.start(self, "_start_load", path)
