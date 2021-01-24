extends Node


export (Array, String) var stage_list
export (String) var final_stage_path
export (NodePath) var scene_loader_path
export (NodePath) var loading_ui_path

onready var scene_loader := get_node(scene_loader_path)
onready var loading_ui := get_node(loading_ui_path)


func _ready():
	print("===")
	print("stage_list: ", stage_list)
	print("final_stage_path: ", final_stage_path)
	print("===")


func _on_NormalGate_on_interact():
	print("rand_range(0, stage_list.size()): ", rand_range(0, stage_list.size()))
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
