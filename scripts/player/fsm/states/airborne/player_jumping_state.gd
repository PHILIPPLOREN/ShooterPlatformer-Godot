class_name PlayerJumpingState extends PlayerAirborneStates

func enter(from: StringName) -> void:
    animator.play("jump")
    player.velocity_y = player.JUMP_FORCE

func update(_delta: float) -> void:
    super(_delta)

    if player.velocity.y >= 0:
        transition.emit("PlayerFallingState")