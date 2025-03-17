class_name Debug extends Control

@onready var property_container: VBoxContainer = %VBoxContainer

func _ready() -> void:
	G.debug = self

func _input(event: InputEvent) -> void:
	if event.is_action_pressed("debug"):
		visible = not visible

func add_property(title: String, value, order: int):
	var target := property_container.find_child(title, true, false)
	if not target:
		target = Label.new()
		property_container.add_child(target)
		target.name = title
		target.text = target.name + ": " + str(value)
	elif visible:
		target.text = title + ": " + str(value)
		property_container.move_child(target, order)