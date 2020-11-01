extends Area2D


onready var stage_list := [
	"res://scene/stage/normal_stage/stage_1.tscn",
	"res://scene/stage/normal_stage/stage_2.tscn",
	"res://scene/stage/normal_stage/stage_3.tscn"
]
onready var next_stage_path := ""


func _ready():
	next_stage_path = stage_list[int(rand_range(0, stage_list.size()))]


func _on_NextStage_body_entered(body):
	owner.get_tree().change_scene(next_stage_path)
