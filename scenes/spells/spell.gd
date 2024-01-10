extends Area2D

var speed: int = 175
var direction: Vector2 = Vector2.RIGHT

func _process(delta):
	position += direction * speed * delta

func _on_timer_timeout():
	queue_free()
