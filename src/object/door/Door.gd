class_name Door
extends StaticBody2D


signal change_room(next_room_path)

export(NodePath) var next_room_path
export(bool) var active := true

onready var door_collision := $DoorCollision
onready var door_area := $DoorArea


func _process(_delta):
	door_area.monitoring = active
	door_collision.disabled = active


func _on_DoorArea_body_entered(body):
	if active:
		emit_signal("change_room", next_room_path)
