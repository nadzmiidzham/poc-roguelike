extends AnimationPlayer


var animation_timer: Timer


func _ready():
	animation_timer = Timer.new()
	animation_timer.connect('timeout', self, '_on_AnimationTimer_timeout')
	self.add_child(animation_timer)


#@param name: string --> effect animation name
#@param duration: int --> timer duration (in seconds)
func activate_effect(name: String, duration: int) -> void:
	self.play(name)
	self.get_animation(self.current_animation).loop = true
	animation_timer.start(duration)

func deactivate_effect() -> void:
	self.get_animation(self.current_animation).loop = false
	animation_timer.stop()


func _on_AnimationTimer_timeout():
	deactivate_effect()
