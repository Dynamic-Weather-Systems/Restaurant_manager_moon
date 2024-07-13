extends Area2D
class_name PickupItem


var picked_up: bool = false
var node_to_follow: CharacterBody2D = null


func _physics_process(delta):
	if picked_up and node_to_follow:
		position = node_to_follow.position
		print(node_to_follow.position)


func pickup(character: CharacterBody2D):
	picked_up = true
	node_to_follow = character

func drop():
	picked_up = false
	node_to_follow = null
