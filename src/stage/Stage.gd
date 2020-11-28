extends Node


export (Array, String) var stage_list
export (String) var final_stage_path

onready var scene_loader := $GameController/SceneLoader
onready var loading_ui := $UI/LoadingUI


func _ready():
	print("stage_list: ", stage_list)
	print("final_stage_path: ", final_stage_path)


func _on_NormalGate_on_interact():
	var next_stage_path = stage_list[int(rand_range(0, stage_list.size()))]
	scene_loader.load_scene(next_stage_path)

func _on_FinalGate_on_interact(stage_type: String):
	match stage_type:
		"normal":
			var next_stage_path = stage_list[int(rand_range(0, stage_list.size()))]
			scene_loader.load_scene(next_stage_path)
		"final":
			scene_loader.load_scene(final_stage_path)


func _on_SceneLoader_on_start_load(max_value: int):
	loading_ui.on_start_load(max_value)

func _on_SceneLoader_on_update_load(value: float):
	loading_ui.update_progress(value + 1)

func _on_SceneLoader_on_finish_load():
	loading_ui.on_finish_load()
