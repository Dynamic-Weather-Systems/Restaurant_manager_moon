extends StaticBody2D


@export  var ingredient: PackedScene
var tabled: bool = false


# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass


func _on_actionable_actioned(node):
	create_ingredient()


func create_ingredient():
	#if tabled:
		#return
	
	tabled = true
	var instance = ingredient.instantiate()
	instance.global_position = global_position + Vector2(0,50)
	get_parent().add_child(instance)
