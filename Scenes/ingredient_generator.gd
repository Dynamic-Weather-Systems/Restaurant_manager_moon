extends StaticBody2D


@export  var ingredient_scene: PackedScene
@export var ingredients: Array[IngredientItem]
var tabled: int = 0


func _on_actionable_actioned(node):
	create_ingredient()


func create_ingredient():
	if tabled:
		return
	
	var instance = ingredient_scene.instantiate()
	instance.ingredient = ingredients[randi_range(0,len(ingredients)-1)]

	instance.global_position = %IngredientSpawnLocation.global_position
	get_parent().add_child(instance)



func _on_table_area_entered(area):
	tabled += 1


func _on_table_area_exited(area):
	tabled -= 1
