extends CharacterBody3D

@onready var nav_agent: NavigationAgent3D = $NavigationAgent3D

const MOVE_SPEED: float = 5.0
const GRAVITY: float = -20.0
const ROTATION_SPEED: float = 10.0

var _target_position: Vector3
var _is_moving: bool = false

func _unhandled_input(event: InputEvent):
	if event is InputEventMouseButton and event.button_index == MOUSE_BUTTON_LEFT and event.pressed:
		# 1. Faz raycast da câmera até o chão
		var camera = get_viewport().get_camera_3d()
		var from = camera.project_ray_origin(event.position)
		var direction = camera.project_ray_normal(event.position)
		
		# 2. Calcula interseção com o plano y=0 (chão)
		var t = -from.y / direction.y
		_target_position = from + direction * t
		_is_moving = true

func _physics_process(delta):
	if not is_on_floor():
		velocity.y += GRAVITY * delta
	
	if _is_moving:
		var diff = _target_position - global_position
		diff.y = 0.0
		if diff.length() > 0.2:  # margem para parar
			velocity.x = diff.normalized().x * MOVE_SPEED
			velocity.z = diff.normalized().z * MOVE_SPEED
		else:
			velocity.x = 0.0
			velocity.z = 0.0
			_is_moving = false
	
	move_and_slide()
