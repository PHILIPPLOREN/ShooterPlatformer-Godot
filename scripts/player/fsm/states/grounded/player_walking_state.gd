class_name PlayerWalkingState extends PlayerGroundStates

func enter(from: StringName) -> void:
    animator.play("walk")

func update(_delta: float) -> void:
    super(_delta)

    if player.input_dir_raw.x == 0:
        transition.emit("PlayerIdleState")