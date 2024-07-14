class_name Actionable
extends Area2D

signal actioned(node: Node)


func action(node: Node):
	actioned.emit(node)
