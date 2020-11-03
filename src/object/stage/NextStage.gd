extends Area2D


export (Array, String) var stage_list

onready var interactable := false


func _process(_delta):
	if interactable && Input.is_action_just_pressed("interact"):
		var next_stage = stage_list[int(rand_range(0, stage_list.size()))]
		owner.get_tree().change_scene(next_stage)


func _on_NormalGate_body_entered(body):
	interactable = true

func _on_NormalGate_body_exited(body):
	interactable = false
