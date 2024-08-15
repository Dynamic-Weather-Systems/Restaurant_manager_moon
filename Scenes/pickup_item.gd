class_name PickupItem
extends CharacterBody2D


var picked_up: bool = false
var node_to_follow: Node2D = null


func _physics_process(delta):
	if picked_up and node_to_follow:
		global_position = node_to_follow.global_position


func pickup(character: CharacterBody2D):
	if character.has_node("PickupItemMarker2D"):
		node_to_follow = character.get_node("PickupItemMarker2D")
	else:
		node_to_follow = character
	
	picked_up = true
	if character.has_method("pickup"):
		character.pickup(self)

func drop(character: CharacterBody2D):
	picked_up = false
	node_to_follow = null
