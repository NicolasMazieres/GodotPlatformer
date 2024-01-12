extends State
class_name PlayerMove

var animation_player: AnimationPlayer
var player: CharacterBody2D

func enter_state():
	print("move State")
	player = $"../.."
	animation_player = $"../../AnimationPlayer"

func update_state(_delta: float):
	animation_player.play("run")
	switch_direction(player.direction)

func physics_update_state(_delta: float):
	if player.direction == 0:
		state_transition.emit(self, "PlayerIdle")
	
	if player.direction:
		player.velocity.x = player.direction * player.SPEED
	else:
		player.velocity.x = move_toward(player.velocity.x, 0, player.SPEED)

func switch_direction(dir):
		if dir != 0:
			player.sprite.flip_h = (dir == -1)
			if dir == -1:
				player.sprite.position.x = 0
