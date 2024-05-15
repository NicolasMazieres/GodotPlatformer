extends SpellParent

var direction: Vector2 = Vector2.RIGHT
var angle: int = 1
var time_since_last_action: float = 0.0
var max_time_without_action: float = 0.5

func _process(delta):
	time_since_last_action += delta
	
	if Input.is_action_just_pressed("up"):
		time_since_last_action = 0.0
		change_spell_direction()
	
	if time_since_last_action >= max_time_without_action:
		queue_free()
	
	position += direction * speed * delta

func change_spell_direction():
	if direction.y == 0 and direction.x >= 0:
		angle = -1
		direction = direction.rotated(deg_to_rad(45 * angle))
	elif direction.y == 0 and direction.x < 0:
		angle = 1
		direction = direction.rotated(deg_to_rad(45 * angle))
	else:
		direction = direction.rotated(deg_to_rad(90 * angle))
	angle = angle * (-1)
