class_name Arm extends Node2D

@onready var arm: Node2D = $Arm

@export var arm_radius: float

var _mouse_position: Vector2
var _direction: Vector2
var _angle: float
var _arm_offset: Vector2

func _process(_delta: float) -> void:
    _mouse_position = get_global_mouse_position()

    # Вычисляем вектор от точки крепления руки к курсору
    _direction = (_mouse_position - global_position).normalized()

    # Вычисляем угол между направлением и осью X
    _angle = _direction.angle()

    # Вычисляем позицию руки на окружности
    _arm_offset = Vector2(cos(_angle), sin(_angle)) * arm_radius

    # Обновляем позицию руки
    arm.position = _arm_offset

    # Поворачиваем руку в направлении курсора
    arm.rotation = _angle