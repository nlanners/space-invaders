extends Node2D

const NUMBER_OF_ROWS: int = 3
const ROW_WIDTH: int = 10
const FIELD_LEFT: int = 0
const FIELD_TOP: int = 16
const ENEMY_HEIGHT: int = 32
const ENEMY_WIDTH: int = 32

enum EnemyType { NONE, ONE, TWO, THREE }

var score: int = 0

const MOVE_SPEED = 20

var direction: int = 1
var move_timer: float = 0
var move_interval: float = 0.5
var should_drop: bool = false

const Enemy = preload("res://scenes/enemy.tscn")
const Mothership = preload("res://scenes/mothership.tscn")

@onready var enemy_box: Area2D = $EnemyBox

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	for i in NUMBER_OF_ROWS * ROW_WIDTH:
		var enemy = Enemy.instantiate()
		enemy.enemy_hit.connect(_on_enemy_hit)
		@warning_ignore("integer_division")
		enemy.position = Vector2(
			(ENEMY_WIDTH / 2) + ((i % ROW_WIDTH) * ENEMY_WIDTH),
			(ENEMY_HEIGHT / 2) + ((i / ROW_WIDTH) * ENEMY_HEIGHT)
		)
		enemy_box.add_child(enemy)


func _process(delta) -> void:
	process_enemy_movement(delta)
	
	if get_tree().get_node_count_in_group("enemies") <= 0:
		pass


func _on_enemy_hit():
	score += 1


func _on_enemy_box_body_entered(_body: Node2D) -> void:
	direction *= -1
	should_drop = true
	

func _on_mothership_hit():
	score += 5


func process_enemy_movement(delta) -> void:
	move_timer += delta

	if move_timer >= move_interval:
		move_timer = 0
		
		if should_drop:
			enemy_box.position.y += ENEMY_HEIGHT
			should_drop = false
		else:
			enemy_box.position.x += MOVE_SPEED * direction


func process_mothership() -> void:
	var mothership = Mothership.instantiate()
	mothership.mothership_hit.connect(_on_mothership_hit)
	add_child(mothership)

func _on_timer_timeout() -> void:
	process_mothership()
