extends Control


onready var progress_bar := $Panel/ProgressBar
onready var loading_tween := $LoadingTween

var thread = null


func _loading_start(path: String):
	var resource_loader = ResourceLoader.load_interactive(path)
	var resource = null

	progress_bar.max_value = resource_loader.get_stage_count()
	while true:
		_update_progress(resource_loader.get_stage() + 1)
		OS.delay_msec(100) # delay by 100 miliseconds

		var err = resource_loader.poll()
		if err == ERR_FILE_EOF: # load operation has completed successfully
			resource = resource_loader.get_resource()
			break
		elif err != OK:
			print("An error has occured during loading")
			break

	call_deferred("_loading_finished", resource)

func _loading_finished(resource: PackedScene):
	thread.wait_to_finish()

	var next_scene = resource.instance()
	get_tree().current_scene.queue_free()
	get_tree().root.add_child(next_scene)
	get_tree().current_scene = next_scene

	self.visible = false

func _update_progress(value: float):
	loading_tween.interpolate_property(
		progress_bar,
		"value",
		progress_bar.value,
		value,
		0.5,
		Tween.TRANS_LINEAR,
		Tween.EASE_IN_OUT)
	loading_tween.start()

	yield(loading_tween, "tween_completed")


func load_scene(path: String):
	thread = Thread.new()
	thread.start(self, "_loading_start", path)
	self.raise() # show this node as the highest in order
	self.visible = true
