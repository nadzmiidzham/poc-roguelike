extends Node


onready var main_menu := $UI/MainMenuUI
onready var option := $UI/OptionUI
onready var loading_ui := $UI/LoadingUI


func _on_MainMenuUI_on_start_new_game():
	loading_ui.load_scene("res://scene/stage/normal_stage/stage_1.tscn")

func _on_MainMenuUI_on_open_option():
	main_menu.visible = false
	option.visible = true

func _on_OptionUI_on_back():
	main_menu.visible = true
	option.visible = false
