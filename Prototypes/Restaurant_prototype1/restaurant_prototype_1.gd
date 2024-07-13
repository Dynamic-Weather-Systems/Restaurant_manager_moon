extends Node2D


@export var customer: PackedScene
@onready var reception = $Reception

func _ready():
	var cust_inst = customer.instantiate()
	reception.add_child(cust_inst)

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if len(reception.get_children()) == 0:
		var cust_inst = customer.instantiate()
		reception.add_child(cust_inst)


func _on_player_customer_dropped(customer, customer_position):
	customer.position = customer_position
	add_child(customer)
	for i in range(10):
		print(customer.get_overlapping_areas())
