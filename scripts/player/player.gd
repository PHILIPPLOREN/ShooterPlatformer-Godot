class_name Player extends CharacterBody2D

const GRAVITY: float = -9.81 * 50.0
const JUMP_FORCE: float = -4.0 * 40.0
const ACCELERATION: float = 13.0

@export var speed: float = 2.0
@export var arm_radius: float = 44.0

@onready var animator: AnimatedSprite2D = $AnimatedSprite2D
@onready var camera: Camera2D = $Camera2D
@onready var arm_pivot: Marker2D = $Node2D/Marker2D

@onready var arm: Node2D = $Node2D/Marker2D/Hand

var _input_dir: Vector2
var input_dir_raw: Vector2
var velocity_y: float

func _ready() -> void:
	G.player1 = self

func _process(delta: float) -> void:

	input_dir_raw = Input.get_vector(
		"move_left",
		"move_right",
		"move_up",
		"move_down")

	_input_dir += input_dir_raw * ACCELERATION * delta
	_input_dir = _input_dir.lerp(Vector2.ZERO, ACCELERATION * delta)
	_input_dir = _input_dir.clamp(-Vector2.ONE, Vector2.ONE)

	velocity = (Vector2.RIGHT * _input_dir.x + Vector2.UP * _input_dir.y) * speed * 50.0

	animator.flip_h = velocity.x < 0

	if not is_on_floor():
		velocity_y -= GRAVITY * delta

	velocity.y = velocity_y

	G.debug.add_property("Input", _input_dir, 1)
	G.debug.add_property("Velocity", velocity, 2)
	G.debug.add_property("Input Raw", input_dir_raw.length(), 5)

	var vel_clamped: float = clamp(velocity.length(), 0.0, 100.0)

	var speed_normalized: float = vel_clamped / 100.0
	speed_normalized = clamp(speed_normalized, 0.0, 1.0)

	var target_zoom: Vector2 = lerp(Vector2.ONE * 5.0, Vector2.ONE * 3.0, speed_normalized)

	camera.zoom = camera.zoom.lerp(target_zoom, 1.5 * delta)

	move_and_slide()
