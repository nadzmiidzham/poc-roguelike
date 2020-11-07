extends Node


export (Array, String) var stage_list
export (String) var final_stage_path

onready var loading_ui := $UI/LoadingUI


func _on_NormalGate_on_interact():
	var next_stage_path = stage_list[int(rand_range(0, stage_list.size()))]
	loading_ui.load_scene(next_stage_path)

func _on_FinalGate_on_interact(stage_type: String):
	match stage_type:
		"normal":
			var next_stage_path = stage_list[int(rand_range(0, stage_list.size()))]
			loading_ui.load_scene(next_stage_path)
		"final":
			loading_ui.load_scene(final_stage_path)
