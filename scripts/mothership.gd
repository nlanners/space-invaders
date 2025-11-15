extends CharacterBody2D


signal mothership_hit()

const SPEED = 300.0

enum MothershipSide {RIGHT = -1, LEFT = 1}

@onready var explosion = $Explosion

func _ready() -> void:
	var side = [MothershipSide.RIGHT, MothershipSide.LEFT].pick_random()

	match side:
		MothershipSide.RIGHT:
			position = Vector2(616, 16)
			velocity.x = SPEED * -1

		MothershipSide.LEFT:
			position = Vector2(-16, 16)
			velocity.x = SPEED


func _physics_process(_delta: float) -> void:
	move_and_slide()

	if position.x > 616 or position.x < -16:
		queue_free()


func hit():
	mothership_hit.emit()
	velocity.x = 0
	$AnimatedSprite2D.visible = false
	explosion.visible = true
	explosion.play()

func _on_explosion_animation_finished() -> void:
	queue_free()
