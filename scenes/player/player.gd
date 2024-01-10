extends CharacterBody2D

signal action_pressed(position: Vector2, flip: bool)

const SPEED = 100.0
const JUMP_VELOCITY = -175.0

@onready var ap = $AnimationPlayer
@onready var sprite = $Sprite2D

# Get the gravity from the project settings to be synced with RigidBody nodes.
var gravity = ProjectSettings.get_setting("physics/2d/default_gravity")
var jump_max_duration : float = 0.25
var jump_duration: float = 0.0

func _physics_process(delta):
	# Add the gravity
	if not is_on_floor():
		velocity.y += gravity * delta

	# Handle jump.
	handle_jump(delta)

	# Get the input direction and handle the movement/deceleration.
	var direction = Input.get_axis("left", "right")
	if direction:
		velocity.x = direction * SPEED
	else:
		velocity.x = move_toward(velocity.x, 0, SPEED)
	
	switch_direction(direction)
	
	# Handle action
	if Input.is_action_just_pressed("action"):
		action_pressed.emit($SpellStartPosition.global_position, sprite.flip_h)
	
	move_and_slide()
	update_movement_animations(direction)
	
func update_movement_animations(direction):
	if is_on_floor():
		if direction != 0:
			ap.play("run", -1, 1.75)
		else:
			ap.play("idle", -1, 0.5)
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

func handle_jump(delta):
	if Input.is_action_just_pressed("jump") and is_on_floor():
		velocity.y = JUMP_VELOCITY
		jump_duration = 0
	
	if Input.is_action_pressed("jump") and not is_on_floor():
		jump_duration += delta
		if jump_duration < jump_max_duration:
			velocity.y += - gravity * delta * 1.05
			
	if Input.is_action_just_released("jump") and not is_on_floor():
		jump_duration = jump_max_duration
	
