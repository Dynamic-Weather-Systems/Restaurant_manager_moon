extends StaticBody2D


@export  var dish_scene: PackedScene
@export var dish: DishItem
var tabled: int = 0


# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


func _on_actionable_actioned(node):
	create_ingredient()


func create_ingredient():
	if tabled:
		return
	
	var instance = dish_scene.instantiate()
	instance.dish = dish

	instance.global_position = %IngredientSpawnLocation.global_position
	get_parent().add_child(instance)



func _on_table_area_entered(area):
	tabled += 1


func _on_table_area_exited(area):
	tabled -= 1
