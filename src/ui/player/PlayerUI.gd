class_name PlayerUI
extends Control


export (int) var max_hp := 100.0
export (int) var max_ep := 100.0
export (int) var max_xp := 100.0
export (int) var secondary_cooldown := 2
export (int) var special_cooldown := 3

enum BAR_TYPE {
	HP, EP, XP
}
enum ATTACK_TYPE {
	SECONDARY, SPECIAL
}

onready var cur_hp := max_hp
onready var cur_ep := max_ep
onready var cur_xp := max_xp

onready var hp_bar := $Bars/BarContainer/HPBar/TextureProgress
onready var ep_bar := $Bars/BarContainer/EPBar/TextureProgress
onready var xp_bar := $Bars/BarContainer/XPBar/TextureProgress
onready var tween := $Tween


func _process(_delta):
	hp_bar.value = 0.0 if (cur_hp == null) else (cur_hp / max_hp) * 100
	ep_bar.value = 0.0 if (cur_ep == null) else (cur_ep / max_ep) * 100
	xp_bar.value = 0.0 if (cur_xp == null) else (cur_xp / max_xp) * 100


func change_value(value: float, type):
	match (type):
		BAR_TYPE.HP:
			cur_hp = value
		BAR_TYPE.EP:
			cur_ep = value
		BAR_TYPE.XP:
			cur_xp = value

func change_max_value(value: float, type):
	match (type):
		BAR_TYPE.HP:
			max_hp = value
		BAR_TYPE.EP:
			max_ep = value
		BAR_TYPE.XP:
			max_xp = value

func start_cooldown(type):
	match (type):
		ATTACK_TYPE.SECONDARY:
			# start secondary cooldown
			pass
		ATTACK_TYPE.SPECIAL:
			# start special cooldown
			pass


func _on_Player_on_hp_changed(value):
	change_value(value, BAR_TYPE.HP)


func _on_Player_on_attack(type):
	start_cooldown(type)
