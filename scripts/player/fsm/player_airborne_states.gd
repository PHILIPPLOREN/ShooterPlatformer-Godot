class_name PlayerAirborneStates extends PlayerStates

func exit() -> void:
    player.velocity_y = 0

func update(_delta: float) -> void:
    if player.is_on_floor():
        transition.emit("PlayerIdleState")