extends State
class_name PlayerFall

var animation_player: AnimationPlayer
var player: CharacterBody2D

func enter_state():
	player = $"../.."
	animation_player = $"../../AnimationPlayer"

func update_state(_delta: float):
	animation_player.play("fall")

func physics_update_state(_delta: float):
	if player.is_on_floor():
		if player.direction.x == 0:
			state_transition.emit(self, "PlayerIdle")
		else:
			state_transition.emit(self, "PlayerMove")
	else:
		if not player.is_jumping and player.coyote_timer < player.COYOTE_TIME and Input.is_action_just_pressed("jump"):
			state_transition.emit(self, "PlayerJump")
	
	if Input.is_action_just_pressed("action"):
		state_transition.emit(self, "PlayerSpell")
