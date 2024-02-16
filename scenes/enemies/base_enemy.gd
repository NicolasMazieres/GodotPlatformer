extends CharacterBody2D

const SPEED: float = 50.0
const WALK_RANGE: float = 30.0
const MAX_HITS: int = 2
const DAMAGE: float = 2.0

var current_position_x: float = 0
var direction: float = 1
var hit_counter: int = 0

# Get the gravity from the project settings to be synced with RigidBody nodes.
var gravity = ProjectSettings.get_setting("physics/2d/default_gravity")

func _physics_process(delta):
	# Add the gravity.
	if not is_on_floor():
		velocity.y += gravity * delta
	
	var old_position_x = position.x
	
	if direction == 1: 
		if current_position_x < WALK_RANGE:
			direction = 1
		else:
			direction = -1
	else:
		if current_position_x < -WALK_RANGE:
			direction = 1
		else:
			direction = -1
	
	velocity.x = direction * SPEED
	switch_direction(direction)
	move_and_slide()
	current_position_x += position.x - old_position_x

func switch_direction(dir):
	$AnimatedSprite2D.flip_h = (dir == 1)

func hit():
	$AnimatedSprite2D.material.set_shader_parameter("progress",0.8)
	$InvulnerabilityTimer.start()
	hit_counter += 1
	if hit_counter >= MAX_HITS:
		queue_free()

func _on_hitbox_body_entered(body):
	if "hit" in body:
		body.hit(self)


func _on_invulnerability_timer_timeout():
	$AnimatedSprite2D.material.set_shader_parameter("progress",0.0)
