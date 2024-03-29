extends Area2D

var speed: int = 350
var direction: Vector2 = Vector2.RIGHT

func _process(delta):
	position += direction * speed * delta

func _on_timer_timeout():
	queue_free()

func _on_body_entered(body):
	if "hit" in body:
		body.hit()
	queue_free()
