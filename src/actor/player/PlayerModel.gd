class_name PlayerModel
extends Node


export (float) var max_hp := 100.0 setget set_max_hp
export (float) var hp := 100.0 setget set_hp
export (float) var max_ep := 50.0 setget set_max_ep
export (float) var ep := 50.0 setget set_ep
export (int) var max_xp := 100 setget set_max_xp
export (int) var xp := 0 setget set_xp
export (float) var atk := 1.0

onready var lvl := 1


func set_max_hp(value: float) -> void:
	max_hp = value

func set_max_ep(value: float) -> void:
	max_ep = value

func set_max_xp(value: int) -> void:
	max_xp = value

func set_hp(value: float) -> void:
	hp = value
	if hp >= max_hp:
		hp = max_hp
	if hp <= 0:
		hp = 0

func set_ep(value: float) -> void:
	ep = value
	if ep >= max_ep:
		ep = max_ep
	if ep <= 0:
		ep = 0

func set_xp(value: int) -> void:
	xp = value
	if xp >= max_xp:
		lvl += 1
		xp = 0
	if xp <= 0:
		xp = 0


func to_string():
	return "PlayerModel: { max_hp: " + str(max_hp) + ", hp: " + str(hp) + ", max_ep: " + str(max_ep) + ", ep: " + str(ep) + ", max_xp: " + str(max_xp) + ", xp: " + str(xp) + ", atk: " + str(atk) + " } "

