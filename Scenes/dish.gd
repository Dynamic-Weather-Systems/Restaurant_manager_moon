extends PickupItem


var dish: DishItem
@onready var actionable = $%Actionable


func _ready():
	set_icon(dish.world_icon)


func _on_actionable_actioned(node: Node):
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
