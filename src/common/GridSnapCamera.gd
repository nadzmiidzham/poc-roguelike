extends Position2D


export(NodePath) var player_node_path

onready var grid_size := get_viewport_rect().size
onready var grid_position := Vector2()
onready var player := get_node(player_node_path)

onready var camera := $Camera2D


func _ready():
	set_as_toplevel(true)
	update_grid_position()

func _physics_process(_delta):
	update_grid_position()


func update_grid_position():
	var new_grid_position = Vector2(
		floor(player.position.x / grid_size.x),
		floor(player.position.y / grid_size.y)
	)

	if grid_position == new_grid_position:
		return

	grid_position = new_grid_position
	self.position = grid_position * grid_size
