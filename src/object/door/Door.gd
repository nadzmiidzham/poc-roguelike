class_name Door
extends StaticBody2D

enum DoorState {
	CLOSE_TO_OPEN,
	OPEN_TO_CLOSE
}

signal on_opened(door)
signal on_closed(door)

export(DoorState) var state := DoorState.OPEN_TO_CLOSE

onready var sprite := $AnimatedSprite
onready var collision := $CollisionShape2D


func _process(_delta):
	match state:
		DoorState.CLOSE_TO_OPEN:
			close()
		DoorState.OPEN_TO_CLOSE:
			open()


func open():
	emit_signal("on_opened", self)
	state = DoorState.OPEN_TO_CLOSE
	collision.set_deferred('disabled', true)
	sprite.play("opening")

func close():
	emit_signal("on_closed", self)
	state = DoorState.CLOSE_TO_OPEN
	collision.set_deferred('disabled', false)
	sprite.play("closing")

func _change_state():
	match state:
		DoorState.CLOSE_TO_OPEN:
			state = DoorState.OPEN_TO_CLOSE
		DoorState.OPEN_TO_CLOSE:
			state = DoorState.CLOSE_TO_OPEN


func _on_Area2D_body_exited(_body):
	_change_state()
