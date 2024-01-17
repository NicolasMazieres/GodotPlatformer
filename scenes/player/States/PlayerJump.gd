extends State
class_name PlayerJump

var animation_player: AnimationPlayer
var player: CharacterBody2D

func enter_state():
	print("Jump State")
	player = $"../.."
	animation_player = $"../../AnimationPlayer"

func update_state(_delta: float):
	animation_player.play("jump")

func physics_update_state(_delta: float):
	if player.is_on_floor():
		state_transition.emit(self, "PlayerIdle")
	elif player.velocity.y > 0 or player.jump_duration >= player.jump_max_duration:
		state_transition.emit(self, "PlayerFall")
	
	if Input.is_action_just_pressed("action"):
		state_transition.emit(self, "PlayerSpell")



