extends State
class_name PlayerSpell

var animation_player: AnimationPlayer
var player: CharacterBody2D
var is_animation_finished: bool

func enter_state():
	player = $"../.."
	animation_player = $"../../AnimationPlayer"
	is_animation_finished = false

func update_state(_delta: float):
	animation_player.play("spell")

func physics_update_state(_delta: float):
	if player.is_on_floor() and Input.is_action_just_pressed("jump"):
		state_transition.emit(self, "PlayerJump")
	
	if is_animation_finished:
		if not player.is_on_floor():
			state_transition.emit(self, "PlayerFall")
		else:
			if player.direction == 0:
				state_transition.emit(self, "PlayerIdle")
			else:
				state_transition.emit(self, "PlayerMove")


func _on_animation_player_animation_finished(anim_name):
	if anim_name == "spell":
		is_animation_finished = true
