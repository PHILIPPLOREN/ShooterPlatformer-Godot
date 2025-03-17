class_name BaseStateMachine extends Node
 
@export var current_state: BaseState

var _states: Dictionary = {}

func _ready() -> void:
	for child in get_children():
		if child is BaseState:
			_states[child.name] = child
			child.transition.connect(on_child_transition)
		else:
			push_warning("State machine contains incompatible child node")

	await owner.ready

	current_state.enter("")

func _process(delta: float) -> void:
	current_state.update(delta)
	G.debug.add_property("State", current_state.name, 3)

func on_child_transition(new_state_name: StringName) -> void:
	var _new_state = _states.get(new_state_name)
	if _new_state:
		if _new_state != current_state:
			current_state.exit()
			_new_state.enter(current_state.name)
			current_state = _new_state
	else:
		push_warning("State doesn't exist")
