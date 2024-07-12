extends CharacterBody2D


@export var SPEED: float = 600.0
@export var ACCEL: float = 15.0
@export var DECEL: float = 15.0

var input_vector: Vector2 = Vector2.ZERO


func _physics_process(delta):
	if input_vector.length() > 0:
		velocity = velocity.lerp(input_vector*SPEED, ACCEL*delta)
	else:
		velocity = velocity.lerp(Vector2.ZERO, DECEL*delta)

	move_and_slide()


func _unhandled_input(event):
	var x_axis = Input.get_axis("move_left", "move_right")
	var y_axis = Input.get_axis("move_up", "move_down")
	
	if x_axis or y_axis:
		input_vector += (x_axis * Vector2.RIGHT) + (y_axis * Vector2.DOWN)
		if input_vector.length() > 1: input_vector = input_vector.normalized()
	else:
		input_vector = Vector2.ZERO
