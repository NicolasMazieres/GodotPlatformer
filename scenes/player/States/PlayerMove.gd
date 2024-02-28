extends State
class_name PlayerMove

var animation_player: AnimationPlayer
var player: CharacterBody2D

func enter_state():
	player = $"../.."
	animation_player = $"../../AnimationPlayer"
	player.is_jumping = false
	player.coyote_timer = 0

func update_state(_delta: float):
	animation_player.play("run")

func physics_update_state(_delta: float):
	if player.direction.x == 0:
		state_transition.emit(self, "PlayerIdle")
		
	if player.velocity.y > 0:
		state_transition.emit(self, "PlayerFall")
		
	if Input.is_action_just_pressed("jump"):
		if player.is_on_floor() or player.coyote_timer < player.COYOTE_TIME:
			state_transition.emit(self, "PlayerJump")
	
	if Input.is_action_just_pressed("action"):
		state_transition.emit(self, "PlayerSpell")
