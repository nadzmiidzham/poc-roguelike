extends Area2D


export (String) var player_body_name := "Player"

onready var label := $Label
onready var interactable := false

func _on_item_body_entered(body):
	if body.name == player_body_name:
		label.show()
		interactable = true

func _on_item_body_exited(body):
	if body.name == player_body_name:
		label.hide()
		interactable = false

func _input(event):
	if interactable && Input.is_action_just_pressed("interact"):
		label.text = "Received potion."
		interactable = false
