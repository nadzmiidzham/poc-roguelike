extends Node2D


signal on_interact()

onready var popup := $InteractPopup

onready var interactable := false


func _process(_delta):
	popup.visible = interactable
	if interactable && Input.is_action_just_pressed("interact"):
		emit_signal("on_interact")


func _on_GateArea_body_entered(_body):
	interactable = true

func _on_GateArea_body_exited(_body):
	interactable = false
