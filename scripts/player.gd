extends CharacterBody2D

@onready var animated_sprite_2d = $AnimatedSprite2D
@onready var jump_sound: AudioStreamPlayer2D = $JumpSound
@onready var death_sound: AudioStreamPlayer2D = $DeathSound

const SPEED = 300.0
const JUMP_VELOCITY = -850.0

var alive = true
var can_move = true


func _physics_process(delta: float) -> void:

	if !alive:
		return

	# Animation
	if velocity.x > 1 or velocity.x < -1:
		animated_sprite_2d.animation = "run"
	else:
		animated_sprite_2d.animation = "idle"

	# Gravity
	if not is_on_floor():
		velocity += get_gravity() * delta
		animated_sprite_2d.animation = "jump"

	# Movement
	if can_move:
		
		# Jump
		if Input.is_action_just_pressed("jump") and is_on_floor():
			velocity.y = JUMP_VELOCITY
			jump_sound.play()

		# Movement
		var direction := Input.get_axis("left", "right")

		if direction:
			velocity.x = direction * SPEED
		else:
			velocity.x = move_toward(velocity.x, 0, SPEED)

		# Flip
		if direction == 1.0:
			animated_sprite_2d.flip_h = false
		elif direction == -1.0:
			animated_sprite_2d.flip_h = true

	else:
		velocity.x = 0

	move_and_slide()


func die() -> void:
	death_sound.play()

	print("DIE FUNCTION DIPANGGIL!")

	alive = false
	can_move = false

	animated_sprite_2d.animation = "hit"
	animated_sprite_2d.play()

	print("Animasi sekarang: ", animated_sprite_2d.animation)
