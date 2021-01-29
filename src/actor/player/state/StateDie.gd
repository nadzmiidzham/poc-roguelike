extends State


signal player_died()

var animation: AnimationPlayer
var player_sprite: Sprite


func _ready():
	player_sprite = owner.get_node('Sprite')
	animation = owner.get_node("Animation")


func on_enter():
	owner.velocity = Vector2(0, owner.velocity.y)
	animation.play("die")


func _on_Animation_animation_finished(anim_name):
	emit_signal("player_died")
