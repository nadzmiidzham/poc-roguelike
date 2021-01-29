extends Node2D


signal on_interact(stage_type)

onready var popup := $InteractPopup
onready var popup_alt := $InteractPopupAlt

onready var interactable := false


func _process(_delta):
	popup.visible = interactable
	popup_alt.visible = interactable

	if interactable && Input.is_action_just_pressed("interact"):
		emit_signal("on_interact", "final")
	if interactable && Input.is_action_just_pressed("interact_alt"):
		emit_signal("on_interact", "normal")


func _on_GateArea_body_entered(_body):
	interactable = true

func _on_GateArea_body_exited(_body):
	interactable = false
