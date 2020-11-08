extends Control


onready var progress_bar := $Panel/ProgressBar
onready var loading_tween := $LoadingTween


func on_start_load(progress_max_value: int) -> void:
	progress_bar.max_value = progress_max_value
	progress_bar.value = 0
	self.raise() # show this node as the highest in order
	self.visible = true

func update_progress(value: float) -> void:
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

func on_finish_load() -> void:
	self.visible = false
