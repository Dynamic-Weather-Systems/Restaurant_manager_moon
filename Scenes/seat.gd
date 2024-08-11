extends StaticBody2D


signal seat_interacted(node: Node, filled: bool)
var available: bool = true


func _on_actionable_actioned(node):
	seat_interacted.emit(self, available)
