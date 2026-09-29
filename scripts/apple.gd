extends Area2D

@onready var animated_sprite_2d: AnimatedSprite2D = $AnimatedSprite2D
@onready var collected_sound: AudioStreamPlayer2D = $CollectedSound
@onready var collision_shape_2d: CollisionShape2D = $CollisionShape2D

signal collected

var is_collected: bool = false


func _ready() -> void:
	pass


func _on_body_entered(body: Node2D) -> void:
	print("🍎 ADA YANG MENYENTUH APPLE: ", body.name)

	if body.name == "Player" and !is_collected:
		print("🍎 APPLE DIAMBIL!")

		is_collected = true

		# Tambah score
		collected.emit()

		# Matikan collision
		call_deferred("_disable_collision")
		set_deferred("monitoring", false)

		# Mainkan suara
		collected_sound.play()

		# Hilangkan Apple langsung
		animated_sprite_2d.visible = false


func _disable_collision() -> void:
	collision_shape_2d.set_deferred("disabled", true)
