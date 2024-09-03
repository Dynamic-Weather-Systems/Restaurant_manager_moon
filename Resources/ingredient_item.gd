class_name IngredientItem
extends Resource


@export var name: String
@export var cook_time: float = 0.0


func cook_ingredient(time: float):
	cook_time += time
