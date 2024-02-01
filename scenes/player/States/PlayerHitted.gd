extends State
class_name PlayerHitted


var animation_player: AnimationPlayer
var player: CharacterBody2D
var is_animation_finished: bool

func enter_state():
	$"../../Timers/InvulnerabilityTimer".start()
	player = $"../.."
	animation_player = $"../../AnimationPlayer"

func update_state(_delta: float):
	animation_player.play("RESET") #hit animation to add

func physics_update_state(_delta: float):
	pass

func _on_invulnerability_timer_timeout():
	state_transition.emit(self, "PlayerIdle")
