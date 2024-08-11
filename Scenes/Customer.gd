extends CharacterBody2D


@export var preferred_dish: String = "dish"
@export var SPEED: float = 600.0
@export var vel_lerp_weight: float = 0.2
@export var sitting_speed: float = 400

enum {
	RECEPTION,
	WALKING,
	SEATING,
	SEATED,
	EATING,
	LEAVING
}

var state = RECEPTION
var follow_node: Node2D = null
var direction: Vector2 = Vector2.ZERO

signal following(node: Node)


func _physics_process(delta):
	var collision_shape = %CollisionShape2D
	collision_shape.disabled = false
	match state:
		RECEPTION:
			velocity = Vector2.ZERO
			pass
		WALKING:
			if global_position.distance_to(follow_node.global_position) <= 150:
				velocity = velocity.lerp(Vector2.ZERO, vel_lerp_weight)
			else:
				direction = Vector2.RIGHT.rotated(get_angle_to(follow_node.global_position))
				velocity = velocity.lerp(direction * SPEED, vel_lerp_weight)
				
		SEATING:
			velocity = Vector2.ZERO
			collision_shape.disabled = true
			direction = Vector2.RIGHT.rotated(get_angle_to(follow_node.global_position))
			global_position = global_position.move_toward(follow_node.global_position,sitting_speed*delta)
			if global_position.distance_to(follow_node.global_position) == 0:
				switch_state(SEATED)

		SEATED:
			collision_shape.disabled = true
			pass
		EATING:
			pass
		LEAVING:
			pass
	
	
	move_and_slide()


func _on_actionable_actioned(node: Node2D):
	print("Customer ", name, " interacted by ", node.name)
	match state:
		RECEPTION:
			print("Customer ", name, " wants ", preferred_dish)
			follow_node = node
			switch_state(WALKING)
			following.emit(self)
		SEATED:
			pass
		EATING:
			pass
		LEAVING:
			pass


func switch_state(new_state):
	state = new_state
