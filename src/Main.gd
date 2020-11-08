extends Node


onready var scene_loader := $GameController/SceneLoader
onready var main_menu_ui := $UI/MainMenuUI
onready var option_ui := $UI/OptionUI
onready var loading_ui := $UI/LoadingUI


func _on_MainMenuUI_on_start_new_game():
	scene_loader.load_scene("res://scene/stage/normal_stage/stage_1.tscn")
	loading_ui.visible = true
	main_menu_ui.visible = false
	option_ui.visible = false

func _on_MainMenuUI_on_open_option():
	loading_ui.visible = false
	main_menu_ui.visible = false
	option_ui.visible = true

func _on_OptionUI_on_back():
	loading_ui.visible = false
	main_menu_ui.visible = true
	option_ui.visible = false


func _on_SceneLoader_on_start_load(max_value: int):
	loading_ui.on_start_load(max_value)

func _on_SceneLoader_on_update_load(value: float):
	loading_ui.update_progress(value + 1)

func _on_SceneLoader_on_finish_load():
	loading_ui.on_finish_load()
