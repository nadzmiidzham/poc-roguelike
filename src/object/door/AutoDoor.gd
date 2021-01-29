class_name AutoDoor
extends StaticBody2D

enum DoorState {
	CLOSED,
	OPENED
}

signal on_opened(door)
signal on_closed(door)
signal on_player_enter(door)

export(DoorState) var state := DoorState.OPENED

onready var sprite := $AnimatedSprite
onready var collision := $DoorCollision
onready var detect_area := $DetectArea


func _ready():
	match state:
		DoorState.CLOSED:
			close()
		DoorState.OPENED:
			open()


func open():
	emit_signal("on_opened", self)
	state = DoorState.OPENED
	collision.set_deferred('disabled', true)
	sprite.play("opening")

func close():
	emit_signal("on_closed", self)
	state = DoorState.CLOSED
	collision.set_deferred('disabled', false)
	sprite.play("closing")


func _on_DetectArea_body_entered(body):
	emit_signal("on_player_enter", self)
	close()
