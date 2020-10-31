class_name PlayerService
extends Node


onready var model := $Model as PlayerModel


func get_stat() -> PlayerModel:
	return model as PlayerModel


func attack() -> float:
	return model.atk

func damaged(damage: float) -> float:
	model.set_hp(model.hp - damage)
	return model.hp

func consume_ep(ep_cost: float) -> float:
	model.set_ep(model.ep - ep_cost)
	return model.ep

func update_atk(value: int) -> void:
	model.atk = value

func damaged(value: float) -> void:
	model.hp -= value
	if model.hp <= 0:
		model.hp = 0

func received_xp(value: int) -> int:
	model.set_xp(model.xp + value)
	return model.xp
