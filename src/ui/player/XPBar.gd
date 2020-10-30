extends BaseBar


func _ready():
	progress.value = 0.0


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

	tween.start()
