extends CharacterBody2D

signal action_pressed(position: Vector2, flip: bool)
signal player_hurt()

const SPEED = 100.0
const JUMP_VELOCITY = -175.0

@onready var state_machine = $StateMachine
@onready var sprite = $Sprite2D
@onready var STATE_IDLE = $StateMachine/PlayerIdle
@onready var STATE_MOVE = $StateMachine/PlayerMove
@onready var STATE_JUMP = $StateMachine/PlayerJump
@onready var STATE_FALL = $StateMachine/PlayerFall
@onready var STATE_SPELL = $StateMachine/PlayerSpell
@onready var STATE_HITTED = $StateMachine/PlayerHurt

# Get the gravity from the project settings to be synced with RigidBody nodes.
var gravity = ProjectSettings.get_setting("physics/2d/default_gravity")
var jump_max_duration : float = 0.25
var jump_duration: float = 0.0
var direction: Vector2 = Vector2.ZERO
var can_spell: bool = true
var recoil_direction: Vector2
var input_queue: Array = [null]

func _physics_process(delta):
	# Add the gravity
	if not is_on_floor():
		velocity.y += gravity * delta

	# Get the input direction
	direction.x = handle_input_movement().x

	match state_machine.current_state:
		STATE_MOVE:
			handle_x_movement(direction)
			
		STATE_JUMP:
			handle_x_movement(direction)
			velocity.y = JUMP_VELOCITY
			if Input.is_action_pressed("jump") and not is_on_floor():
				jump_duration += delta
			if jump_duration < jump_max_duration:
				velocity.y += - gravity * delta * 1.05
			if Input.is_action_just_released("jump") and not is_on_floor():
				jump_duration = jump_max_duration
		
		STATE_FALL:
			handle_x_movement(direction)
			jump_duration = 0
		
		STATE_IDLE:
			handle_x_movement(direction)
			velocity.x = move_toward(velocity.x, 0, SPEED)
			velocity.y = 0
		
		STATE_SPELL:
			handle_x_movement(direction)
			if can_spell:
				can_spell = false
				$Timers/SpellCooldown.start()
				action_pressed.emit($SpellStartPosition.global_position, sprite.flip_h)
		
		STATE_HITTED:
			var hit_recoil: Vector2 = Vector2(15, -5) * $Timers/InvulnerabilityTimer.time_left
			hit_recoil.x *= recoil_direction.x
			velocity = hit_recoil * SPEED
		
	move_and_slide()
	switch_direction(direction.x)
		

func handle_input_movement() -> Vector2:
	for input in ["left", "right"]:
		if Input.is_action_just_pressed(input):
			input_queue.push_back(input)
		if Input.is_action_just_released(input):
			input_queue.erase(input)
	match input_queue.back():
		"left": return Vector2.LEFT
		"right": return Vector2.RIGHT
		_ : return Vector2.ZERO

func switch_direction(dir: float):
	if dir != 0:
		sprite.flip_h = (dir == -1)
		if dir == -1:
			sprite.position.x = 0

func handle_x_movement(dir: Vector2):
	if dir:
		velocity.x = dir.x * SPEED
	else:
		velocity.x = move_toward(velocity.x, 0, SPEED)
	

func _on_spell_cooldown_timeout():
	can_spell = true

func hit(body):
	recoil_direction = (self.position - body.position).normalized()
	if recoil_direction.x >=0:
		recoil_direction.x = 1.0
	else:
		recoil_direction.x = -1.0
	
	player_hurt.emit()
	
