class_name PlayerUI
extends Control


onready var hp_bar := $Bars/BarContainer/HPBar
onready var ep_bar := $Bars/BarContainer/EPBar
onready var xp_bar := $Bars/BarContainer/XPBar
onready var secondary_skill_trigger := $Skills/SkillContainer/SecondarySkillTrigger
onready var special_skill_trigger := $Skills/SkillContainer/SpecialSkillTrigger


func _on_Player_on_attack(type):
	match type:
		PlayerAttackType.SECONDARY:
			secondary_skill_trigger.trigger_skill()
		PlayerAttackType.SPECIAL:
			special_skill_trigger.trigger_skill()

func _on_Player_on_stat_changed(payload):
	var player_state = payload as PlayerModel

	hp_bar.set_max_value(player_state.max_hp)
	hp_bar.set_cur_value(player_state.hp)
	ep_bar.set_max_value(player_state.max_ep)
	ep_bar.set_cur_value(player_state.ep)
	xp_bar.set_max_value(player_state.max_xp)
	xp_bar.set_cur_value(player_state.xp)
