extends Control


func _on_NewGameButton_pressed():
	get_tree().change_scene("res://src/ui/main_menu/scene/new_game_scene.tscn")

func _on_OptionButton_pressed():
	get_tree().change_scene("res://src/ui/main_menu/scene/option_scene.tscn")

func _on_ExitGameButton_pressed():
	get_tree().quit()
