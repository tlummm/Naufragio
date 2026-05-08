extends CharacterBody3D

const MOVE_SPEED: float = 5.0
const GRAVITY: float = -20.0

func _physics_process(delta: float) -> void:
	if not is_on_floor():
		velocity.y += GRAVITY * delta
	move_and_slide()
