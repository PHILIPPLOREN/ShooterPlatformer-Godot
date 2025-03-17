extends CharacterBody2D

const GRAVITY: float = -9.81 * 50.0
const JUMP_FORCE: float = -4.0 * 40.0
const ACCELERATION: float = 13.0

@export var speed: float = 2.0

@onready var _animator: AnimatedSprite2D = $AnimatedSprite2D
@onready var _label: Label = $Label

var _velocity_y: float
var _is_chasing: bool = false
var _is_alive: bool = true

@onready var _hp: int = 5:
	get: return _hp
	set(value):
		_hp = value
		_label.text = "HP: " + str(_hp)

func _process(delta: float) -> void:
	if not _is_alive:
		return

	if is_on_floor():
		_velocity_y = 0
	else:
		_velocity_y -= GRAVITY * delta

	velocity.y = _velocity_y

	if _is_chasing:
		velocity.x = (G.player1.position - position).normalized().x * 2.0 * 25.0
		_animator.flip_h = velocity.x < 0
	else:
		velocity.x = 0

	move_and_slide()


func _on_area_2d_body_entered(body: Node2D) -> void:
	if body.name != "Player":
		return
		
	_is_chasing = true
	_animator.play("walk")


func _on_area_2d_body_exited(body: Node2D) -> void:
	if body.name != "Player":
		return
		
	_is_chasing = false
	_animator.play("idle")


func _on_death_body_entered(body: Node2D) -> void:
	if body is not Player:
		return

	_hp -= 1

	_animator.play("take_hit")
	await _animator.animation_finished

	if _hp <= 0:

		$CollisionShape2D.queue_free()
		$Death/CollisionShape2D.queue_free()
		$Death/CollisionShape2D.queue_free()

		_is_alive = false

		_animator.play("death")
		await _animator.animation_finished
		queue_free()
	
	else:
		_animator.play("walk")