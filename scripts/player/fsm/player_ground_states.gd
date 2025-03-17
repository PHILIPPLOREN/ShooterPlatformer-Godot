class_name PlayerGroundStates extends PlayerStates

func update(_delta: float) -> void:
    if not player.is_on_floor():
        transition.emit("PlayerFallingState")

    if Input.is_action_pressed("jump"):
        transition.emit("PlayerJumpingState")