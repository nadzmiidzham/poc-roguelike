extends State


signal player_died

export (NodePath) var player_model_path

onready var player_model: PlayerModel = get_node(player_model_path)

var animation: AnimationPlayer


func _ready():
	animation = owner.get_node("Animation")


func on_enter():
	owner.velocity = Vector2(0, owner.velocity.y)
	animation.play("die")


func _on_Animation_animation_finished(anim_name):
	if player_model.hp <= 0:
		emit_signal("player_died")
