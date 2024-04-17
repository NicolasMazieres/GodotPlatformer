extends SpellParent

func _process(delta):
	position += direction * speed * delta
