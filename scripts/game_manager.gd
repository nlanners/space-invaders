extends Node2D

const NUMBER_OF_ROWS: int = 3
const ROW_WIDTH: int = 10
const FIELD_LEFT: int = 440
const FIELD_TOP: int = 350
const ENEMY_HEIGHT: int = 32
const ENEMY_WIDTH: int = 32

enum EnemyType {NONE, ONE, TWO, THREE}

const Enemy = preload("res://scenes/enemy.tscn")

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	@warning_ignore("integer_division")
	var field_left = 300 + (300 - ((ENEMY_WIDTH * ROW_WIDTH) / 2))
	for i in NUMBER_OF_ROWS * ROW_WIDTH:
		var enemy = Enemy.instantiate()
		enemy.add_to_group("enemies")
		enemy.enemy_type = [EnemyType.ONE, EnemyType.TWO, EnemyType.THREE].pick_random()
		@warning_ignore("integer_division")
		enemy.global_position = Vector2(
			field_left + (ENEMY_WIDTH / 2) + ((i % ROW_WIDTH) * ENEMY_WIDTH),
			FIELD_TOP + ((i / ROW_WIDTH) * ENEMY_HEIGHT) 
		)
		add_child(enemy)


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta: float) -> void:
	pass
