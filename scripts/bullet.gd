extends CharacterBody2D

const SPEED = 500


func start(_position, direction):
	position = _position
	velocity = Vector2(0, SPEED * direction)


func _physics_process(delta: float) -> void:
	var collision = move_and_collide(velocity * delta)
	if collision:
		var collider = collision.get_collider()
		if collider.has_method("hit"):
			collider.hit()
			queue_free()
