extends State
class_name PlayerIdle

var animation_player: AnimationPlayer
var player: CharacterBody2D

func enter_state():
	player = $"../.."
	animation_player = $"../../AnimationPlayer"
	player.is_jumping = false
	player.coyote_timer = 0
	$"../../Sprite2D".material.set_shader_parameter("progress",0.0)

func update_state(_delta: float):
	animation_player.play("idle",-1,0.75)

func physics_update_state(_delta: float):
	if player.direction.x != 0:
		state_transition.emit(self, "PlayerMove")
	
	if Input.is_action_just_pressed("jump") and player.is_on_floor():
		state_transition.emit(self, "PlayerJump")

	if player.velocity.y > 0:
		state_transition.emit(self, "PlayerFall")
	
	if Input.is_action_just_pressed("action"):
		state_transition.emit(self, "PlayerSpell")

