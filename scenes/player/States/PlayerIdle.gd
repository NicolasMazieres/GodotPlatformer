extends State
class_name PlayerIdle

var animation_player: AnimationPlayer
var player: CharacterBody2D

func enter_state():
	print("Idle State")
	player = $"../.."
	animation_player = $"../../AnimationPlayer"

func update_state(_delta: float):
	animation_player.play("idle")

func physics_update_state(_delta: float):
	if player.direction != 0:
		state_transition.emit(self, "PlayerMove")
	
	if Input.is_action_just_pressed("jump") and player.is_on_floor():
		state_transition.emit(self, "PlayerJump")

	if player.velocity.y > 0:
		state_transition.emit(self, "PlayerFall")


