class_name MetroidDetectArea
extends Area2D


export(NodePath) var cam_path
export(MetroidvaniaCamera.Behaviour) var cam_behaviour
export(bool) var disabled
export(bool) var starting_pos

onready var cam: MetroidvaniaCamera = get_node(cam_path)

onready var collision := $DetectAreaCollision
onready var boundary_topleft := $Boundary/TopLeftBoundary
onready var boundary_bottomright := $Boundary/BottomRightBoundary

onready var old_behaviour: int = MetroidvaniaCamera.Behaviour.FREE
onready var old_height: float = ProjectSettings.get("display/window/size/height")
onready var old_width: float = ProjectSettings.get("display/window/size/width")
onready var old_boundary = null
onready var is_entered := false


func _process(_delta):
	if disabled:
		is_entered = false

	collision.disabled = disabled


func _on_MetroidDetectArea_body_exited(_body):
	is_entered = !is_entered
	print('entered' if is_entered else 'exited')

	if starting_pos:
		disabled = true

	if !cam.get_current_cam():
		cam.set_current_cam(true)

	if is_entered:
		old_behaviour = cam.get_cam_behaviour()
		old_height = cam.get_cam_height()
		old_width = cam.get_cam_width()
		old_boundary = cam.get_cam_boundary()
		cam.set_cam_position(collision.position)
		cam.set_cam_height(_generate_height())
		cam.set_cam_width(_generate_width())
		cam.set_cam_behaviour(cam_behaviour)
		cam.set_cam_boundary(
			boundary_topleft.position.y,
			boundary_bottomright.position.y,
			boundary_topleft.position.x,
			boundary_bottomright.position.x
		)
	else:
		cam.set_cam_position(collision.position)
		cam.set_cam_height(old_height)
		cam.set_cam_width(old_width)
		cam.set_cam_behaviour(old_behaviour)
		cam.set_cam_boundary(
			old_boundary.top,
			old_boundary.bottom,
			old_boundary.left,
			old_boundary.right
		)


func set_disabled(value: bool):
	self.disabled = value

func _generate_height() -> float:
	return abs(boundary_topleft.position.y - boundary_bottomright.position.y)

func _generate_width() -> float:
	return abs(boundary_topleft.position.x - boundary_bottomright.position.x)
