extends CharacterBody2D


@export var preferred_dish: String = "dish"

enum {
	RECEPTION,
	WALKING,
	SEATED,
	EATING,
	LEAVING
}

var state = RECEPTION

func _physics_process(delta):
	match state:
		RECEPTION:
			pass
		WALKING:
			pass
		SEATED:
			pass
		EATING:
			pass
		LEAVING:
			pass
		


func _on_actionable_actioned(node: Node):
	print("Customer ", name, " interacted by ", node.name)
	match state:
		RECEPTION:
			print("Customer ", name, " wants ", preferred_dish)
			state = WALKING
		WALKING:
			pass
		SEATED:
			pass
		EATING:
			pass
		LEAVING:
			pass
