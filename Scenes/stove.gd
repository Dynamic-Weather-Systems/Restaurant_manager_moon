extends StaticBody2D


@export var cook_amount: float = 1
@export  var dish_scene: PackedScene

@onready var dishSprite = %Sprite2D
@onready var cookTimer = %CookTimer

var active: bool = false

var dish: DishItem = null:
	set(value):
		dish = value
		if value == null:
			active = false
			dishSprite.texture = null
			cookTimer.stop()
		else:
			active = true
			dishSprite.texture = dish.world_icon
			cookTimer.start(2)

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	print(dish)


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
