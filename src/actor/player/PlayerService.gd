class_name PlayerService
extends Node


onready var model := $Model as PlayerModel


func get_stat() -> PlayerModel:
	return model as PlayerModel

func attack() -> float:
	return model.atk

func damaged(damage: float) -> float:
	model.set_hp(model.hp - damage)
	owner.stat_changed()
	return model.hp

func consume_ep(ep_cost: float) -> float:
	model.set_ep(model.ep - ep_cost)
	owner.stat_changed()
	return model.ep

func received_xp(value: int) -> int:
	model.set_xp(model.xp + value)
	owner.stat_changed()
	return model.xp
