extends PickupItem


var dish: DishItem
@onready var actionable = $%Actionable


func _ready():
	set_icon(dish.world_icon)


func _process(delta):
	print(len(dish.ingredients))
	if len(dish.ingredients):
		print(dish.ingredients[-1].name, " ", dish.ingredients[-1].cook_time)


func _on_actionable_actioned(node: Node):
	if node.is_in_group("ingredient"):
		print("Added ingredient ", node.ingredient.name)
		dish.add_ingredient(node.ingredient)
		node.queue_free()
	elif node.is_in_group("player"):
		pickup(node)


func set_icon(icon: Texture2D):
	var sprite = %Sprite2D
	sprite.texture = icon

func drop(character: CharacterBody2D):
	super(character)
	var customers = actionable.get_overlapping_areas()
	if len(customers) > 0:
		customers[0].action(self)
		queue_free()


func cook_dish(time: float):
	dish.cook_dish(time)
