class_name DishItem
extends Resource


@export var name: String
@export var world_icon: Texture2D
@export var ingredients: Array[IngredientItem]


func add_ingredient(new_ingredient: IngredientItem):
	for ingredient in ingredients:
		if new_ingredient.name == ingredient.name:
			return
	ingredients.append(new_ingredient.duplicate())


func cook_dish(time: float):
	for ingrient in ingredients:
		ingrient.cook_ingredient(time)


