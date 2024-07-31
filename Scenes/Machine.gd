extends StaticBody2D


var active: bool = false
@onready var progressBar = %ProgressBar
@export var progressSpeed: float = 5.0


func _ready():
	progressBar.value = 0


func _process(delta):
	if active:
		progressBar.value += progressSpeed * delta


func _on_actionable_actioned(node):
	activate()


func _unhandled_input(event):
	if active:
		get_viewport().set_input_as_handled()
		if Input.is_action_just_pressed("drop"):
			deactivate()


func activate():
	active = true

func deactivate():
	active = false
