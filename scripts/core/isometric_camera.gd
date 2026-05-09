extends Camera3D

@export var target: CharacterBody3D
@export var follow_speed: float = 8.0
@export var offset: Vector3 = Vector3(0.0, 15.0, 10.0)

func _physics_process(delta: float) -> void:
	if not is_instance_valid(target):
		return
	var target_pos: Vector3 = target.global_position + offset
	global_position = global_position.lerp(target_pos, follow_speed * delta)
