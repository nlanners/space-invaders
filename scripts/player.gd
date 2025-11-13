extends CharacterBody2D

signal ship_hit()

const SPEED = 300.0

const Bullet = preload("res://scenes/bullet.tscn")
@onready var muzzle: Marker2D = $Muzzle
@onready var explosion: AnimatedSprite2D = $Explosion
@onready var sprite_2d: Sprite2D = $Sprite2D


func _physics_process(_delta: float) -> void:
	# Handle shoot.
	if Input.is_action_just_pressed("shoot"):
		shoot()

	# Get the input direction and handle the movement/deceleration.
	# As good practice, you should replace UI actions with custom gameplay actions.
	var direction := Input.get_axis("left", "right")
	if direction:
		velocity.x = direction * SPEED
	else:
		velocity.x = move_toward(velocity.x, 0, SPEED)

	move_and_slide()


func shoot():
	var bullet = Bullet.instantiate()
	bullet.set_collision_mask_value(1, true)
	bullet.start($Muzzle.global_position, -1)
	get_tree().root.add_child(bullet)


func hit():
	ship_hit.emit()
	sprite_2d.visible = false
	explosion.visible = true
	explosion.play()


func _on_explosion_animation_finished() -> void:
	queue_free()
