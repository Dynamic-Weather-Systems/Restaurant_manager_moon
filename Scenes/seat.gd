extends StaticBody2D


signal seat_interacted(node: Node)


func _on_actionable_actioned(node):
	seat_interacted.emit(self)
