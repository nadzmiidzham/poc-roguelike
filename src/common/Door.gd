extends StaticBody2D


signal on_enter(door)

onready var exit := $Exit


func _on_Area2D_body_entered(body: Node2D):
	emit_signal("on_enter", self)
	body.position = exit.global_position
