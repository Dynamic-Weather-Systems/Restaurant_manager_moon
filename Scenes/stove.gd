extends StaticBody2D


@export var cook_amount: float = 1
@export  var dish_scene: PackedScene

@onready var dishSprite = %DishSprite2D
@onready var cookTimer = %CookTimer
@onready var cookAnimation = %CookingAnimation


var active: bool = false

var dish: DishItem = null:
	set(value):
		dish = value
		if value == null:
			active = false
			dishSprite.texture = null
			cookTimer.stop()
			cookAnimation.stop()
			cookAnimation.hide()
		else:
			active = true
			dishSprite.texture = dish.world_icon
			cookTimer.start(2)
			cookAnimation.play("default")
			cookAnimation.show()


func _on_actionable_actioned(node):
	if node.is_in_group("player"):
		if not dish:
			return
		var instance = dish_scene.instantiate()
		instance.dish = dish.duplicate()

		instance.global_position = %DishSpawnLocation.global_position
		get_parent().add_child(instance)
		
		node.pickup(instance)
		instance.pickup(node)
		dish = null
		
	if node.is_in_group("dish"):
		dish = node.dish


func _on_cook_timer_timeout():
	assert(not dish == null)
	dish.cook_dish(cook_amount)
