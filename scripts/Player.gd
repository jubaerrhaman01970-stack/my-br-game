extends CharacterBody3D

# ===== Movement settings (tune these to change the "feel") =====
@export var walk_speed: float = 4.5
@export var sprint_speed: float = 7.5
@export var crouch_speed: float = 2.0
@export var jump_velocity: float = 4.8
@export var acceleration: float = 10.0
@export var air_control: float = 3.0
@export var mouse_sensitivity: float = 0.15

@export var standing_height: float = 1.8
@export var crouching_height: float = 1.0

var gravity: float = ProjectSettings.get_setting("physics/3d/default_gravity")
var is_crouching: bool = false
var camera_pivot: Node3D
var collision_shape: CollisionShape3D
var mesh_instance: MeshInstance3D

func _ready() -> void:
	camera_pivot = $CameraPivot
	collision_shape = $CollisionShape3D
	mesh_instance = $MeshInstance3D
	Input.set_mouse_mode(Input.MOUSE_MODE_CAPTURED)

func _unhandled_input(event: InputEvent) -> void:
	# Mouse look (like Free Fire's camera drag, but simplified for PC testing)
	if event is InputEventMouseMotion and Input.get_mouse_mode() == Input.MOUSE_MODE_CAPTURED:
		rotate_y(deg_to_rad(-event.relative.x * mouse_sensitivity))
		camera_pivot.rotate_x(deg_to_rad(-event.relative.y * mouse_sensitivity))
		camera_pivot.rotation.x = clamp(camera_pivot.rotation.x, deg_to_rad(-80), deg_to_rad(80))

	if event is InputEventKey and event.pressed and event.keycode == KEY_ESCAPE:
		Input.set_mouse_mode(Input.MOUSE_MODE_VISIBLE)

func _physics_process(delta: float) -> void:
	# Gravity
	if not is_on_floor():
		velocity.y -= gravity * delta
	else:
		if Input.is_action_just_pressed("jump") and not is_crouching:
			velocity.y = jump_velocity

	# Crouch toggle
	if Input.is_action_just_pressed("crouch"):
		is_crouching = not is_crouching
		_update_crouch()

	# Movement input direction (relative to where player is facing)
	var input_dir := Vector2(
		Input.get_action_strength("move_right") - Input.get_action_strength("move_left"),
		Input.get_action_strength("move_back") - Input.get_action_strength("move_forward")
	)
	var direction := (transform.basis * Vector3(input_dir.x, 0, input_dir.y)).normalized()

	var target_speed := walk_speed
	if is_crouching:
		target_speed = crouch_speed
	elif Input.is_action_pressed("sprint") and input_dir.y < 0:
		target_speed = sprint_speed

	var accel := acceleration if is_on_floor() else air_control

	if direction:
		velocity.x = move_toward(velocity.x, direction.x * target_speed, accel * delta * target_speed)
		velocity.z = move_toward(velocity.z, direction.z * target_speed, accel * delta * target_speed)
	else:
		velocity.x = move_toward(velocity.x, 0, accel * delta * target_speed)
		velocity.z = move_toward(velocity.z, 0, accel * delta * target_speed)

	move_and_slide()

func _update_crouch() -> void:
	var tween := create_tween()
	var target_height: float = crouching_height if is_crouching else standing_height
	var shape: CapsuleShape3D = collision_shape.shape
	tween.tween_property(shape, "height", target_height, 0.15)
	tween.parallel().tween_property(collision_shape, "position:y", target_height / 2.0, 0.15)
	tween.parallel().tween_property(mesh_instance, "position:y", target_height / 2.0, 0.15)
	tween.parallel().tween_property(mesh_instance.mesh, "height", target_height, 0.15) if mesh_instance.mesh is CapsuleMesh else null
