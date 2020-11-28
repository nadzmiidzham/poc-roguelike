class_name Door
extends StaticBody2D

enum DoorState {
	CLOSED,
	OPENED
}

signal on_opened(door)
signal on_closed(door)

export(DoorState) var state := DoorState.OPENED

onready var sprite := $AnimatedSprite
onready var collision := $CollisionShape2D


func _ready():
	match state:
		DoorState.CLOSED:
			close()
		DoorState.OPENED:
			open()


func open():
	sprite.play("opening")
	collision.disabled = true
	emit_signal("on_opened", self)

func close():
	sprite.play("closing")
	collision.disabled = false
	emit_signal("on_closed", self)
