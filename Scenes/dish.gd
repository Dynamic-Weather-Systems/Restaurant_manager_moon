extends PickupItem


var dish: DishItem


func _ready():
	set_icon(dish.world_icon)


func _on_actionable_actioned(node: Node):
	pickup(node)


func set_icon(icon: Texture2D):
	var sprite = %Sprite2D
	sprite.texture = icon
