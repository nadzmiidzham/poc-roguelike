extends Area2D


export (String, FILE, "*.tscn,*.scn") var next_stage_prefab


func _on_NextStage_body_entered(body):
	owner.get_tree().change_scene(next_stage_prefab)
