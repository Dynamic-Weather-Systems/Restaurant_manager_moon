extends Node2D


@export var customer_scene: PackedScene
@export var MAX_QUEUE: int = 10
var score = 0
var customer_count = 0
var following_customer: Node = null
var dish_queue = []

func _ready():
	for seat in %Seats.get_children():
		seat.seat_interacted.connect(_on_seat_seat_interacted)


func game_over():
	$MobTimer.stop()

func new_game():
	score = 0
	customer_count = 0


func _on_customer_timer_timeout():
	if customer_count >= MAX_QUEUE: return
	spawn_customer()


func spawn_customer():
	# Create a new instance of the Mob scene.
	var customer = customer_scene.instantiate()

	# Choose a random location on Path2D.
	var customer_spawn_location = $CustomerPath/CustomerSpawnLocation
	customer_spawn_location.progress_ratio = randf()

	# Set the mob's direction perpendicular to the path direction.
	var direction = customer_spawn_location.rotation + PI / 2

	# Set the mob's position to a random location.
	customer.position = customer_spawn_location.position

	# Spawn the mob by adding it to the Main scene
	add_child(customer)
	customer.following.connect(_on_customer_following)
	customer.placed_order.connect(_on_order_placed)
	customer.ate.connect(_on_customer_ate)
	customer_count += 1
	return customer


func _on_customer_following(node: Node):
	following_customer = node


func _on_order_placed(customer: Node, order: DishItem):
	dish_queue.append([customer, order])


func _on_customer_ate(customer: Node, dish: DishItem):
	var index = dish_queue.find([customer,dish])
	
	if not index == -1: dish_queue.remove_at(index)
	for seat in %Seats.get_children():
		if seat.customer == customer:
			seat.available = true
			seat.customer = null



func _on_seat_seat_interacted(seat: Node, available):
	if following_customer == null:
		return
	if not available:
		return
		
	following_customer.follow_node = seat
	seat.available = false
	following_customer.state = following_customer.SEATING
	seat.customer = following_customer
	following_customer = null
