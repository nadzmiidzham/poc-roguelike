extends Node2D


export (Array, String) var stage_list

onready var popup := $InteractPopup
onready var loading_screen := $CanvasLayer/LoadingScreen

onready var interactable := false


func _process(_delta):
	popup.visible = interactable
	if interactable && Input.is_action_just_pressed("interact"):
		var next_stage_path = stage_list[int(rand_range(0, stage_list.size()))]
		loading_screen.load_scene(next_stage_path)


func _on_GateArea_body_entered(_body):
	interactable = true

func _on_GateArea_body_exited(_body):
	interactable = false
