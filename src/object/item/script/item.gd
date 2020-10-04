extends Area2D


func _on_item_body_entered(body):
	print("Entering item area")

func _on_item_body_exited(body):
	print("Exiting item area")
