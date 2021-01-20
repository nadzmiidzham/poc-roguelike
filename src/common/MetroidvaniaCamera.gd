class_name MetroidvaniaCamera
extends Camera2D


enum Behaviour {
	HORIZONTAL,
	VERTICAL,
	FIXED,
	FREE
}


export(NodePath) var entity_path
export(Behaviour) var behaviour

onready var entity: Node2D = get_node(entity_path)
onready var height: float = ProjectSettings.get("display/window/size/height")
onready var width: float = ProjectSettings.get("display/window/size/width")
onready var screen_height: float = ProjectSettings.get("display/window/size/height")
onready var screen_width: float = ProjectSettings.get("display/window/size/width")

var starting_position: bool = true


func _process(_delta):
	match behaviour:
		Behaviour.HORIZONTAL:
			# 1. cam will follow player on x axis only
			# 2. cam will zoom out to fit boundary height (limit)
			position = Vector2(entity.position.x, position.y)
			_zoom_to_fit_boundary_height(height)
		Behaviour.VERTICAL:
			# 1. cam will follow player on y axis only
			# 2. cam will zoom out to fit boundary width (limit)
			position = Vector2(position.x, entity.position.y)
			_zoom_to_fit_boundary_width(width)
		Behaviour.FREE:
			# 1. cam will follow entity on x & y axis
			# 2. cam will zoom in on entity
			# 3. cam will reset height & width
			height = screen_height
			width = screen_width
			position = entity.position
			zoom = Vector2(1, 1)
		Behaviour.FIXED:
			# 1. cam will not follow entity
			# 2. cam will zoom out to fit boundary width
			# 3. cam will be at the center of boundary
			_zoom_to_fit_boundary_width(width)
			_center_cam()


func set_current_cam(value: bool):
	current = value

func set_cam_height(new_height: float):
	height = new_height

func set_cam_width(new_width: float):
	width = new_width

func set_cam_behaviour(new_behaviour: int):
	behaviour = new_behaviour

func set_cam_position(new_position: Vector2):
	if behaviour == Behaviour.FREE:
		position = new_position
		return
	if behaviour == Behaviour.VERTICAL:
		position.x = new_position.x
		return

	position.y = new_position.y

func set_cam_boundary(top, bottom, left, right):
	limit_top = top
	limit_bottom = bottom
	limit_left = left
	limit_right = right


func get_current_cam():
	return current

func get_cam_height():
	return height

func get_cam_width():
	return width

func get_cam_behaviour():
	return behaviour

func get_cam_position():
	return position

func get_cam_boundary():
	return {
		'top': limit_top,
		'bottom': limit_bottom,
		'left': limit_left,
		'right': limit_right
	}


func _center_cam():
	var center_x = abs((limit_left - limit_right) / 2)
	var center_y = abs((limit_top - limit_bottom) / 2)

	position = Vector2(center_x, center_y)

func _zoom_to_fit_boundary_height(height: float):
	if (height <= 0) || (height == screen_height):
		return

	var zoom_ratio = height / screen_height
	zoom = Vector2(zoom_ratio, zoom_ratio)

func _zoom_to_fit_boundary_width(width: float):
	if (width <= 0) || (width == screen_width):
		return

	var zoom_ratio = width / screen_width
	zoom = Vector2(zoom_ratio, zoom_ratio)
