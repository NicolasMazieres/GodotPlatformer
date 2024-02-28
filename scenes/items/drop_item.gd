extends CharacterBody2D

var gravity = ProjectSettings.get_setting("physics/2d/default_gravity")
var rotation_speed: int = 40
var initial_speed: int = randi_range(100,150)
var initial_direction: Vector2 = Vector2(randf_range(-1,1), -1).normalized()

func _ready():
	velocity = initial_direction * initial_speed

func _process(delta):
	rotation += rotation_speed * delta

func _physics_process(delta):
	if not is_on_floor():
		velocity.y += gravity * delta /2
		move_and_slide()

func _on_area_2d_body_entered(_body):
	queue_free()
