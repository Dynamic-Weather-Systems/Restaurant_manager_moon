extends CharacterBody2D


@export var preferred_dish: DishItem
@export var SPEED: float = 600.0
@export var vel_lerp_weight: float = 0.2
@export var sitting_speed: float = 400

@onready var spriteRotation = %SpriteRotation


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
var customer_name = randi()

signal following(node: Node)
signal placed_order(customer: Node, dish: DishItem)
signal ate(customer: Node, dish: DishItem)


func _physics_process(delta):
	var collision_shape = %CollisionShape2D
	collision_shape.disabled = false
	match state:
		RECEPTION:
			velocity = Vector2.ZERO
			pass
		WALKING:
			direction = Vector2.RIGHT.rotated(get_angle_to(follow_node.global_position))
			spriteRotation.rotation = atan2(direction.y, direction.x)
			if global_position.distance_to(follow_node.global_position) <= 150:
				velocity = velocity.lerp(Vector2.ZERO, vel_lerp_weight)
			else:
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
	match state:
		RECEPTION:
			if node.is_in_group("pickup_item"): return
			follow_node = node
			switch_state(WALKING)
			following.emit(self)
			placed_order.emit(self,preferred_dish)
		SEATED:
			if not node.is_in_group("dish"): return
			print(name + " was fed " + node.dish.name)
			ate.emit(self,node.dish)
			queue_free()
		EATING:
			pass
		LEAVING:
			pass


func switch_state(new_state):
	state = new_state
