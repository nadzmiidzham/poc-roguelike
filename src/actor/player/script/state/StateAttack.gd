extends State

var animation


func on_enter():
	animation = owner.get_node("Animation")
	animation.play("jump")


func _on_animation_finished(_name):
	emit_signal("change_state", "previous")
