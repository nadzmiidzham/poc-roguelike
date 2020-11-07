extends BaseBar


onready var hp_label := $Progress/HPLabel


func set_cur_value(value: float) -> void:
	# animate progress bar
	tween.interpolate_property(
		progress,
		"value",
		progress.value,
		value,
		0.6,
		Tween.TRANS_LINEAR,
		Tween.EASE_OUT)

	# animate progress number
	tween.interpolate_method(
		self,
		"_set_label",
		progress.value,
		value,
		0.6,
		Tween.TRANS_LINEAR,
		Tween.EASE_OUT)

	tween.start()


func _set_label(value):
	hp_label.text = str(round(value)) + " / " + str(max_value)

