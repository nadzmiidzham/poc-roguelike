extends Area2D


export(float) var damage: float

onready var collision := $Collision


func _on_Hazard_area_entered(area):
	if area.has_method('on_damaged'):
		area.on_damaged(damage)
