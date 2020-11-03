extends Area2D


export (Array, String) var stage_list


func _on_RandomStage_body_entered(body):
	var next_stage = stage_list[int(rand_range(0, stage_list.size()))]
	owner.get_tree().change_scene(next_stage)
