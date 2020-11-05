extends Control


onready var loading_screen := $LoadingScreen


func _on_NewGameButton_pressed():
	loading_screen.load_scene("res://scene/stage/normal_stage/stage_1.tscn")

func _on_OptionButton_pressed():
	get_tree().change_scene("res://scene/main_menu/option_scene.tscn")

func _on_ExitGameButton_pressed():
	get_tree().quit()
