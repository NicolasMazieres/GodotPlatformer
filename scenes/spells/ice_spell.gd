extends SpellParent

var direction: Vector2 = Vector2.RIGHT

func _process(delta):
	position += direction * speed * delta
