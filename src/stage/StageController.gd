extends Node


export(NodePath) var starting_detector_path
export(NodePath) var first_room_detector_path

onready var starting_detector: MetroidDetectArea = get_node(starting_detector_path)
onready var first_room_detector: MetroidDetectArea = get_node(first_room_detector_path)


func _ready():
	starting_detector.set_disabled(true)


func _on_starting_detector_exited(body):
	print('starting_detector exited')
	starting_detector.set_disabled(true)
	first_room_detector.set_disabled(false)

func _on_first_room_detector_exited(body):
	print('first_room_detector exited')
	starting_detector.set_disabled(false)
	first_room_detector.set_disabled(true)
