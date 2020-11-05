extends Node2D


export (Array, String) var stage_path_list
export (Array, String) var final_stage_path_list

onready var popup := $InteractPopup
onready var popup_alt := $InteractPopupAlt
onready var loading_screen := $CanvasLayer/LoadingScreen

onready var interactable := false


func _process(_delta):
	popup.visible = interactable
	popup_alt.visible = interactable

	if interactable && Input.is_action_just_pressed("interact"):
		var final_stage_path = final_stage_path_list[int(rand_range(0, final_stage_path_list.size()))]
		loading_screen.load_scene(final_stage_path)
	if interactable && Input.is_action_just_pressed("interact_alt"):
		var next_stage_path = stage_path_list[int(rand_range(0, stage_path_list.size()))]
		loading_screen.load_scene(next_stage_path)


func _on_GateArea_body_entered(body):
	interactable = true

func _on_GateArea_body_exited(body):
	interactable = false
