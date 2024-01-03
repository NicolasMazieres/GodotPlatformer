extends CharacterBody2D

const SPEED = 150.0
const JUMP_VELOCITY = -350.0

@onready var ap = $AnimationPlayer
@onready var sprite = $Sprite2D

# Get the gravity from the project settings to be synced with RigidBody nodes.
var gravity = ProjectSettings.get_setting("physics/2d/default_gravity")

func _physics_process(delta):
	# Add the gravity.
	if not is_on_floor():
		velocity.y += gravity * delta

	# Handle jump.
	if Input.is_action_just_pressed("jump") and is_on_floor():
		velocity.y = JUMP_VELOCITY

	# Get the input direction and handle the movement/deceleration.
	var direction = Input.get_axis("left", "right")
	if direction:
		velocity.x = direction * SPEED
	else:
		velocity.x = move_toward(velocity.x, 0, SPEED)
	
	switch_direction(direction)
	
	move_and_slide()
	update_animations(direction)
	
func update_animations(direction):
	if is_on_floor():
		if direction != 0:
			ap.play("walk")
	else:
		if velocity.y < 0:
			ap.play("jump")
		else:
			ap.play("fall")

func switch_direction(direction):
		if direction != 0:
			sprite.flip_h = (direction == -1)
			if direction == -1:
				sprite.position.x = 0
	
