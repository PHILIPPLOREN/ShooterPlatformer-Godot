class_name PlayerFallingState extends PlayerAirborneStates

func enter(from: StringName) -> void:
	animator.play("fall")

func update(_delta: float) -> void:
	super(_delta)
	
	if animator.frame >= 5:
		animator.frame = 5
