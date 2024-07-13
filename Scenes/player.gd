extends CharacterBody2D


@export var SPEED: float = 600.0
@export var ACCEL: float = 15.0
@export var DECEL: float = 15.0

@export var interacting_area: Area2D

var input_vector: Vector2 = Vector2.ZERO
var held: PickupItem = null

signal player_dropping(node: Node)


func _physics_process(delta):
	if input_vector.length() > 0:
		velocity = velocity.lerp(input_vector*SPEED, ACCEL*delta)
	else:
		velocity = velocity.lerp(Vector2.ZERO, DECEL*delta)

	move_and_slide()


func _unhandled_input(event):
	
	if Input.is_action_just_pressed("interact"):
		var interactables = interacting_area.get_overlapping_areas()
		print(interactables)
		if interactables.size() > 0:
			print(interactables[0])
			if interactables[0].is_in_group("actionable"):
				interactables[0].action()
				input_vector = Vector2.ZERO
				return 
			if not held:
				pickup(interactables[0])
	
	if Input.is_action_just_pressed("drop"):
		if held:
			drop(held)
	
	# get strength of movement inputs
	var x_axis = Input.get_axis("move_left", "move_right")
	var y_axis = Input.get_axis("move_up", "move_down")
	
	# calculate input vector, normalize if magnitude larger than 1
	if x_axis or y_axis:
		input_vector += (x_axis * Vector2.RIGHT) + (y_axis * Vector2.DOWN)
		if input_vector.length() > 1: input_vector = input_vector.normalized()
	else:
		input_vector = Vector2.ZERO
	
	# point towards mouse
	if event is InputEventMouseMotion:
		look_at(get_global_mouse_position())


func drop(item: PickupItem):
	held = null
	item.drop()


func pickup(item: PickupItem):
	held = item
	item.pickup(self)
	print(item)
	
