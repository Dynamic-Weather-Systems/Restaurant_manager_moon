class_name DishItem
extends Resource


@export var name: String
@export var world_icon: Texture2D
@export var ingredients: Array[IngredientItem]


func add_ingredient(ingredient: IngredientItem):
	ingredients.append(ingredient)


func cook_dish(time: float):
	for ingrient in ingredients:
		ingrient.cook_ingredient(time)


