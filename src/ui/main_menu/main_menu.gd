extends Control


signal on_start_new_game()
signal on_open_option()


func _on_NewGameButton_pressed():
	emit_signal("on_start_new_game")

func _on_OptionButton_pressed():
	emit_signal("on_open_option")

func _on_ExitGameButton_pressed():
	get_tree().quit()
