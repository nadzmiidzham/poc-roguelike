extends Node2D


onready var tilemap := $TileMap


func set_enabled(value: bool):
	if value:
		self.show()
	else:
		self.hide()

	set_process(value)
	set_process_internal(value)
	set_physics_process(value)
	set_physics_process_internal(value)
	set_process_input(value)
	set_process_unhandled_input(value)
	set_process_unhandled_key_input(value)
