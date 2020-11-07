extends Control


signal on_back()


func _on_ExitGameButton_pressed():
	emit_signal("on_back")
