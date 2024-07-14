extends CharacterBody2D


func _on_actionable_actioned(node: Node):
	print("Customer ", name, " interacted by ", node.name)
