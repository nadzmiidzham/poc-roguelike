extends State


export(String) var action_button := "attack_basic"
export(float) var timer_interval := 0.3
export(Array) var combo = [
	{
		"animation": "attack_basic_1",
		"effect": null,
		"damage": 1
	},
	{
		"animation": "attack_basic_2",
		"effect": null,
		"damage": 1
	},
	{
		"animation": "attack_basic_3",
		"effect": null,
		"damage": 1
	}
]

onready var combo_count := 0
onready var combo_finished := false
onready var animation_finished := true
onready var timer_finished := false

var timer
var animation
var cur_animation_name


func _ready():
	# initialize timer
	timer = Timer.new()
	timer.one_shot = true
	timer.wait_time = timer_interval
	timer.connect("timeout", self, "_on_Timer_timeout")
	add_child(timer)


func on_enter():
	# player cannot move while attacking on ground
	if owner.is_grounded():
		owner.velocity.x = 0

	# play attack animation
	cur_animation_name = combo[combo_count].animation
	animation = owner.get_node("Animation")
	animation.play(cur_animation_name)

func on_exit():
	combo_finished = false
	timer_finished = false
	animation_finished = true
	combo_count = 0
	timer.stop()


func process(_delta):
	combo_finished = timer_finished || (combo_count >= combo.size())

	if combo_finished:
		emit_signal("change_state", "previous")

	# input for next combo attack animation
	if !combo_finished && animation_finished && Input.is_action_just_pressed(action_button):
		cur_animation_name = combo[combo_count].animation # play current attack combo animation
		animation_finished = false # start a new animation
		timer_finished = false # reset timer due to received input for next attack combo animation
		animation.play(cur_animation_name)


func _on_Animation_animation_finished(anim_name):
	if anim_name == cur_animation_name:
		combo_count += 1 # increment combo to access next attack combo animation
		animation_finished = true # notify attack animation has finished
		timer.start() # start timer after attack animation finish to check for further attack input

func _on_Timer_timeout():
	if animation_finished:
		timer_finished = true # notify timer finished if there's no further input after animation finished
