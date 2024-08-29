class_name IngredientItem
extends Resource


@export var name: String
@export var cook_time: float = 0.0


#func _init(new_name: String = "TestIngredient", new_cook_time: float = 0.0):
	#name = new_name
	#cook_time = new_cook_time

func cook_ingredient(time: float):
	cook_time += time
