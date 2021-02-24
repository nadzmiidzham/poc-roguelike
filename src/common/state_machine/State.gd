class_name State
extends Node


export (NodePath) var state_machine_path

onready var state_machine := get_node(state_machine_path)


func on_enter(data: Dictionary = {}) -> void:
	pass

func on_exit() -> void:
	pass


func process(_delta) -> void:
	pass

func physics_process(_delta) -> void:
	pass
