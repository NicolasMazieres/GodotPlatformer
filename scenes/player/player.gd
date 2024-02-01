extends CharacterBody2D

signal action_pressed(position: Vector2, flip: bool)
signal player_hitted(body: CollisionShape2D)

const SPEED = 100.0
const JUMP_VELOCITY = -175.0

@onready var state_machine = $StateMachine
@onready var sprite = $Sprite2D
@onready var STATE_IDLE = $StateMachine/PlayerIdle
@onready var STATE_MOVE = $StateMachine/PlayerMove
@onready var STATE_JUMP = $StateMachine/PlayerJump
@onready var STATE_FALL = $StateMachine/PlayerFall
@onready var STATE_HITTED = $StateMachine/PlayerHitted

# Get the gravity from the project settings to be synced with RigidBody nodes.
var gravity = ProjectSettings.get_setting("physics/2d/default_gravity")
var jump_max_duration : float = 0.25
var jump_duration: float = 0.0
var direction: float = 0.0
var can_spell: bool = true
var recoil_direction: Vector2

func _physics_process(delta):
	# Add the gravity
	if not is_on_floor():
		velocity.y += gravity * delta

	# Get the input direction
	direction = Input.get_axis("left", "right")

	match state_machine.current_state:
		STATE_JUMP:
			velocity.y = JUMP_VELOCITY
			if Input.is_action_pressed("jump") and not is_on_floor():
				jump_duration += delta
			if jump_duration < jump_max_duration:
				velocity.y += - gravity * delta * 1.05
			if Input.is_action_just_released("jump") and not is_on_floor():
				jump_duration = jump_max_duration
		
		STATE_FALL:
			jump_duration = 0
		
		STATE_IDLE:
			velocity.x = move_toward(velocity.x, 0, SPEED)
			velocity.y = 0
		
		STATE_HITTED:
			direction = recoil_direction.x

	# Handle action
	if Input.is_action_just_pressed("action") and can_spell:
		can_spell = false
		$Timers/SpellCooldown.start()
		action_pressed.emit($SpellStartPosition.global_position, sprite.flip_h)
		
	
	handle_x_movement(direction)
	move_and_slide()
	switch_direction(direction)
		

func switch_direction(dir):
	if dir != 0:
		sprite.flip_h = (dir == -1)
		if dir == -1:
			sprite.position.x = 0

func handle_x_movement(dir: float):
	if dir:
		velocity.x = dir * SPEED
	else:
		velocity.x = move_toward(velocity.x, 0, SPEED)
	

func _on_spell_cooldown_timeout():
	can_spell = true

func hit(body):
	print("player hitted")
	recoil_direction = (self.position - body.position).normalized()
	player_hitted.emit()
