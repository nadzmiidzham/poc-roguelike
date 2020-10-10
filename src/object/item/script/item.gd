class_name Interactable
extends Area2D


onready var label := $Label
onready var interactable := false


func _process(delta):
	if interactable:
		label.show()
	else:
		label.hide()

func _input(_event):
	if interactable && Input.is_action_just_pressed("interact"):
		label.text = "Received potion." # interact action here
		interactable = false


func _on_Interactable_body_entered(body):
	print('entered')
	interactable = true

func _on_Interactable_body_exited(body):
	print('exited')
	interactable = false
