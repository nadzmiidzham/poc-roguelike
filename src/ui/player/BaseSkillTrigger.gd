class_name BaseSkillTrigger
extends VBoxContainer


export (float) var cooldown_duration := 5.0

onready var progress := $TriggerProgress
onready var cooldown_label := $TriggerProgress/CooldownLabel
onready var tween := $Tween


func _ready():
	cooldown_duration = 0.0 if (cooldown_duration == null) else cooldown_duration
	progress.value = 0.0

func _process(_delta):
	cooldown_label.visible = (progress.value > 0)


func set_cooldown_duration(seconds: float) -> void:
	cooldown_duration = seconds
	progress.max_value = seconds

func trigger_skill() -> void:
	# animate progress bar
	tween.interpolate_property(
		progress,
		"value",
		progress.max_value,
		progress.min_value,
		cooldown_duration,
		Tween.TRANS_LINEAR,
		Tween.EASE_OUT)

	# animate progress number
	tween.interpolate_method(
		self,
		"_set_cooldown_label",
		cooldown_duration,
		0,
		cooldown_duration,
		Tween.TRANS_LINEAR,
		Tween.EASE_OUT)

	tween.start()


func _set_cooldown_label(value):
	if value <= 1:
		cooldown_label.text = str(stepify(value, 0.01)) # show 2 decimal value
	else:
		cooldown_label.text = str(round(value))
