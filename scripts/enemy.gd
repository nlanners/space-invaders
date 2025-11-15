extends CharacterBody2D

enum EnemyType { NONE, ONE, TWO, THREE }

signal enemy_hit

@export var enemy_type: EnemyType

@onready var enemy_1: AnimatedSprite2D = $Enemy1
@onready var enemy_2: AnimatedSprite2D = $Enemy2
@onready var enemy_3: AnimatedSprite2D = $Enemy3
@onready var explosion: AnimatedSprite2D = $Explosion
@onready var collision_shape_2d: CollisionShape2D = $CollisionShape2D
@onready var muzzle: Marker2D = $Muzzle

const Bullet = preload("res://scenes/bullet.tscn")

const SHOT_CHANCE = .0005

var move_timer = 0
var move_interval = 0.5
var animation_node: AnimatedSprite2D

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	if not enemy_type:
		enemy_type = [EnemyType.ONE, EnemyType.TWO, EnemyType.THREE].pick_random()
	match enemy_type:
		EnemyType.ONE:
			enemy_1.visible = true
			animation_node = enemy_1
		EnemyType.TWO:
			enemy_2.visible = true
			animation_node = enemy_2
		EnemyType.THREE:
			enemy_3.visible = true
			animation_node = enemy_3
	
	add_to_group("enemies")


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	move_timer += delta
	if move_timer >= move_interval:
		move_timer = 0

		if animation_node.frame == 0:
			animation_node.frame = 1
		else:
			animation_node.frame = 0
			
	if randf() < SHOT_CHANCE:
		shoot()


func hit():
	enemy_hit.emit()
	collision_shape_2d.queue_free()
	animation_node.visible = false
	explosion.visible = true
	explosion.play()


func shoot():
	var bullet = Bullet.instantiate()
	bullet.set_collision_mask_value(4, true)
	bullet.start(muzzle.global_position, 1)
	get_tree().root.add_child(bullet)


func _on_explosion_animation_finished() -> void:
	queue_free()
