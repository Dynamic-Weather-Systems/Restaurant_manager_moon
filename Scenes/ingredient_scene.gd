extends PickupItem

@export var ingredient: IngredientItem
@onready var actionable = %Actionable


func _ready():
	var sprite = %Sprite2D
	sprite.texture = ingredient.world_icon


func _on_actionable_actioned(node):
	pickup(node)


func drop(character: CharacterBody2D):
	super(character)
	var areas = actionable.get_overlapping_areas()
	if len(areas) >= 1:
		areas[0].action(self)
