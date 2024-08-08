extends CharacterBody2D


@export var preferred_dish: String = "dish"
@export var SPEED: float = 600.0
@export var vel_lerp_weight: float = 0.2

enum {
	RECEPTION,
	WALKING,
	SEATED,
	EATING,
	LEAVING
}

var state = RECEPTION
var follow_node: Node2D = null
var direction: Vector2 = Vector2.ZERO

signal following(node: Node)


func _physics_process(delta):
	
	match state:
		RECEPTION:
			velocity = Vector2.ZERO
			move_and_slide()
			pass
		WALKING:
			if global_position.distance_to(follow_node.global_position) <= 150:
				velocity = velocity.lerp(Vector2.ZERO, vel_lerp_weight)
			else:
				direction = Vector2.RIGHT.rotated(get_angle_to(follow_node.global_position))
				velocity = velocity.lerp(direction * SPEED, vel_lerp_weight)
				
			move_and_slide()

		SEATED:
			pass
		EATING:
			pass
		LEAVING:
			pass
		


func _on_actionable_actioned(node: Node2D):
	print("Customer ", name, " interacted by ", node.name)
	match state:
		RECEPTION:
			print("Customer ", name, " wants ", preferred_dish)
			follow_node = node
			switch_state(WALKING)
			following.emit(self)
		WALKING:
			pass
		SEATED:
			pass
		EATING:
			pass
		LEAVING:
			pass


func switch_state(new_state):
	state = new_state
