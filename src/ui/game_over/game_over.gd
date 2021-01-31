extends Control


export(PackedScene) var main_menu


func _on_BtnExit_pressed():
	get_tree().quit()

func _on_BtnMainMenu_pressed():
	get_tree().change_scene(main_menu.resource_path)
