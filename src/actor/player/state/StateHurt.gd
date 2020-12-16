extends State


export(int) var hurt_duration: int

var animation: AnimationPlayer
var effect_animation: AnimationPlayer
var player_sprite: Sprite


func _ready():
	player_sprite = owner.get_node('Sprite')
	animation = owner.get_node("Animation")
	effect_animation = owner.get_node("EffectAnimation")


func on_enter():
	owner.velocity = Vector2(0, owner.velocity.y)
	animation.play("hurt")


func _on_Animation_animation_finished(anim_name):
	if anim_name == 'hurt':
		effect_animation.activate_effect('hurting', hurt_duration)
		emit_signal("change_state", "idle")

func _on_EffectAnimation_animation_finished(anim_name):
	if anim_name == 'hurting':
		player_sprite.visible = true
