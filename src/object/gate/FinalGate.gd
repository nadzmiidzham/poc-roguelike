extends Node2D


export (Array, String) var stage_path_list
export (Array, String) var final_stage_path_list

onready var popup := $InteractPopup
onready var popup_alt := $InteractPopupAlt

onready var interactable := false


func _process(_delta):
	popup.visible = interactable
	popup_alt.visible = interactable

	if interactable && Input.is_action_just_pressed("interact"):
		var final_stage = final_stage_path_list[int(rand_range(0, final_stage_path_list.size()))]
		owner.get_tree().change_scene(final_stage)
	if interactable && Input.is_action_just_pressed("interact_alt"):
		var next_stage = stage_path_list[int(rand_range(0, stage_path_list.size()))]
		owner.get_tree().change_scene(next_stage)


func _on_GateArea_body_entered(body):
	interactable = true

func _on_GateArea_body_exited(body):
	interactable = false
