extends State
class_name PlayerHitted


var animation_player: AnimationPlayer
var player: CharacterBody2D 
var is_animation_finished: bool

func enter_state():
	player = $"../.."
	animation_player = $"../../AnimationPlayer"
	$"../../Timers/InvulnerabilityTimer".start()
	$"../../Sprite2D".material.set_shader_parameter("progress",0.8)

func update_state(_delta: float):
	animation_player.play("hit")

func physics_update_state(_delta: float):
	pass

func _on_invulnerability_timer_timeout():
	$"../../Sprite2D".material.set_shader_parameter("progress",0.0)
	if player.is_on_floor():
		state_transition.emit(self, "PlayerIdle")
	else:
		state_transition.emit(self, "PlayerFall")
