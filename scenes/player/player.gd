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
var direction: float = 0.0

func _physics_process(delta):
	# Add the gravity
	if not is_on_floor():
		velocity.y += gravity * delta

	# Handle jump.
	handle_jump(delta)

	# Get the input direction
	direction = Input.get_axis("left", "right")
	
	# Handle action
	if Input.is_action_just_pressed("action"):
		action_pressed.emit($SpellStartPosition.global_position, sprite.flip_h)
	
	move_and_slide()
	update_movement_animations(direction)
	
func update_movement_animations(dir):
	if !is_on_floor():
		if velocity.y < 0:
			ap.play("jump")
		else:
			ap.play("fall")

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
	
