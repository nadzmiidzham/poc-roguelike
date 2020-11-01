class_name BaseBar
extends HBoxContainer


export (float) var max_value := 100.0

onready var progress := $Progress
onready var tween := $Tween


func _ready():
	max_value = 0.0 if (max_value == null) else max_value
	progress.max_value = max_value
	progress.min_value = 0.0
	progress.value = max_value


func set_cur_value(value: float) -> void:
	tween.interpolate_property(
		progress,
		"value",
		progress.value,
		value,
		0.6,
		Tween.TRANS_LINEAR,
		Tween.EASE_OUT)
	tween.start()

func set_max_value(value: float) -> void:
	max_value = value
	progress.max_value = value
