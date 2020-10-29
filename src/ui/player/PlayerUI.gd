class_name PlayerUI
extends Control


onready var hp_bar := $Bars/BarContainer/HPBar
onready var ep_bar := $Bars/BarContainer/EPBar
onready var xp_bar := $Bars/BarContainer/XPBar
onready var secondary_skill_trigger := $Skills/SkillContainer/SecondarySkillTrigger
onready var special_skill_trigger := $Skills/SkillContainer/SpecialSkillTrigger


func _set_hp(value: float):
	hp_bar.set_cur_value(value)

func _set_ep(value: float):
	ep_bar.set_cur_value(value)

func _set_xp(value: float):
	xp_bar.set_cur_value(value)


func _on_Player_on_attack(type):
	match type:
		"SECONDARY":
			secondary_skill_trigger.trigger_skill()
		"SPECIAL":
			special_skill_trigger.trigger_skill()


func _on_Player_on_hp_changed(value):
	_set_hp(value)

func _on_Player_on_ep_changed(value):
	_set_ep(value)

func _on_Player_on_xp_changed(value):
	_set_xp(value)
