extends StaticBody2D


signal on_enter(door, exit_direction)

export(Vector2) var exit_direction := Vector2.ZERO

onready var exit := $Exit


func _on_Area2D_body_entered(body: Node2D):
	emit_signal("on_enter", self, exit_direction)
	body.position = exit.global_position
