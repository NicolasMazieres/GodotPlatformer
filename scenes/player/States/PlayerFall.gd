extends State
class_name PlayerFall

var animation_player: AnimationPlayer
var player: CharacterBody2D

func enter_state():
	print("Fall State")
	player = $"../.."
	animation_player = $"../../AnimationPlayer"

func update_state(_delta: float):
	animation_player.play("fall")

func physics_update_state(_delta: float):
	if player.is_on_floor():
		if player.direction == 0:
			state_transition.emit(self, "PlayerIdle")
		else:
			state_transition.emit(self, "PlayerMove")
	
	if Input.is_action_just_pressed("action"):
		state_transition.emit(self, "PlayerSpell")
