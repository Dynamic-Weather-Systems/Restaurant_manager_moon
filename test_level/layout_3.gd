extends Node2D


@export var customer_scene: PackedScene
@export var MAX_QUEUE: int = 10
var score = 0
var customer_count = 0
var following_customer: Node = null


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
	customer_count += 1


func _on_customer_following(node: Node):
	following_customer = node


func _on_seat_seat_interacted(node: Node):
	assert(following_customer != null)
	following_customer.follow_node = node
	print(following_customer, " sat at seat ", node)
