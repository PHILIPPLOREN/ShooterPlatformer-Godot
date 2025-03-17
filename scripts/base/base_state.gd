class_name BaseState extends Node

signal transition(state_name: StringName)

func enter(from: StringName) -> void:
    pass

func exit() -> void:
    pass

func update(delta: float) -> void:
    pass