extends CharacterBody2D


@export var SPEED: float = 700.0
@export var ACCEL: float = 100.
@export var DECCEL: float = 100.

@onready var pickup_area = $PickupArea

var input_vector: Vector2 = Vector2.ZERO
var mousePos: Vector2
var held: Node = null

signal  customer_dropped(customer: Node, customer_position: Vector2)

func _physics_process(delta):
	if input_vector.length() > 1:
		input_vector = input_vector.normalized()
		
	if input_vector.length() > 0:
		velocity = velocity.move_toward(input_vector * SPEED, ACCEL)
	else:
		velocity = velocity.move_toward(Vector2.ZERO, DECCEL)
	move_and_slide()


func _unhandled_input(event):
	if event is InputEventMouseMotion:
		var camera_size = get_viewport_rect().size
		look_at(self.position - camera_size/2 + event.position)
	
	var x_axis: float = Input.get_axis("move_left", "move_right")
	var y_axis: float = Input.get_axis("move_up", "move_down")
	
	if x_axis:
		input_vector += x_axis * Vector2.RIGHT
	if y_axis:
		input_vector += y_axis * Vector2.DOWN
	if x_axis == 0 and y_axis == 0:
		input_vector = Vector2.ZERO
	
	if event.is_action_pressed("pickup"):
		if not held:
			var overlapping_areas = pickup_area.get_overlapping_areas()
			for area in overlapping_areas:
				if area.is_in_group("pickup"):
					held = area
					held.get_parent().remove_child(held)
					held.position = Vector2(50,0)
					self.add_child(held)
					break
	elif event.is_action_pressed("drop"):
		if held:
			if held.is_in_group("customer"):
				var cust_position = held.global_position
				self.remove_child(held)
				customer_dropped.emit(held, cust_position)
				held = null
			else:
				var new_position: Vector2 = held.global_position
				self.remove_child(held)
				held.position = new_position
				self.get_parent().add_child(held)
				held = null
