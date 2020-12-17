class_name Door
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
onready var collision := $CollisionShape2D


func _ready():
	match state:
		DoorState.CLOSED:
			close()
		DoorState.OPENED:
			open()


func open():
	emit_signal("on_opened", self)
	state = DoorState.OPENED
	collision.disabled = true
	sprite.play("opening")

func close():
	emit_signal("on_closed", self)
	state = DoorState.CLOSED
	collision.disabled = false
	sprite.play("closing")


func _on_Area2D_body_entered(body):
	emit_signal("on_player_enter", self)
