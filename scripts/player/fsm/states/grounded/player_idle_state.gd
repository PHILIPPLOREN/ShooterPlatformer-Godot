class_name PlayerIdleState extends PlayerGroundStates

func enter(from: StringName) -> void:
	if from == "PlayerFallingState" and animator.animation == "fall":
		animator.play("fall")
		animator.frame = 6
		await animator.animation_finished
	animator.play("idle")

func update(_delta: float) -> void:
	super(_delta)

	if abs(player.velocity.x) >= .1 and player.input_dir_raw.x != 0:
		transition.emit("PlayerWalkingState")
