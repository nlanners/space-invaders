extends CharacterBody2D

enum EnemyType { NONE, ONE, TWO, THREE }

signal enemy_hit

@export var enemy_type: EnemyType

@onready var enemy_1: AnimatedSprite2D = $Enemy1
@onready var enemy_2: AnimatedSprite2D = $Enemy2
@onready var enemy_3: AnimatedSprite2D = $Enemy3


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	if not enemy_type:
		enemy_type = randi_range(1, 3) as EnemyType
	match enemy_type:
		EnemyType.ONE:
			enemy_1.visible = true
		EnemyType.TWO:
			enemy_2.visible = true
		EnemyType.THREE:
			enemy_3.visible = true


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta: float) -> void:
	pass


func hit():
	enemy_hit.emit()
	queue_free()
