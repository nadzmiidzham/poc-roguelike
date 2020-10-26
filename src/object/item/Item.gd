class_name Item
extends StaticBody2D


onready var popup := $InteractPopup

onready var interactable := false
onready var interacted := false


func _input(_event):
	popup.visible = interactable

	if interactable && Input.is_action_just_pressed("interact"):
		if interact():
			popup.visible = false
			interactable = false
			interacted = true


func interact() -> bool:
	print("interacting")
	# interact logic
	return true


func _on_Area2D_body_entered(_body):
	if !interacted:
		interactable = true

func _on_Area2D_body_exited(_body):
	if !interacted:
		interactable = false
