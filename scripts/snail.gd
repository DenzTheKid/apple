extends Area2D

@onready var animated_sprite_2d: AnimatedSprite2D = $AnimatedSprite2D

signal player_died

const SPEED = 50.0

var direction = -1.0
var can_attack: bool = false
var already_hit: bool = false


func _ready() -> void:
	await get_tree().create_timer(0.2).timeout
	can_attack = true


func _process(delta: float) -> void:
	position.x += direction * SPEED * delta


func _on_timer_timeout() -> void:
	direction *= -1
	animated_sprite_2d.flip_h = !animated_sprite_2d.flip_h


func _on_body_entered(body: Node2D) -> void:
	if not can_attack:
		return

	if body.name != "Player":
		return

	if already_hit:
		return

	if not body.alive:
		return

	print("🔥 PLAYER KENA SNAIL!")

	already_hit = true
	can_attack = false

	player_died.emit(body)
