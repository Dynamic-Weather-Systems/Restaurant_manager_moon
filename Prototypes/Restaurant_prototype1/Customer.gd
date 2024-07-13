extends Area2D


@export var water_depletion: float = 1
@export var hunger_depletion: float = 0.5

@onready var waterBar = $WaterBar
@onready var hungerBar = $HungerBar

var water_bar = 100: 
	set(value):
		waterBar.value = value
		water_bar = value

var hunger_bar = 100:
	set(value):
		hungerBar.value = value
		hunger_bar = value

func _ready():
	var sprite = $Sprite
	sprite.play("frame_" + str(randi_range(1,9)))


func _on_timer_timeout():
	water_bar -= water_depletion
	hunger_bar -= hunger_depletion


func quench():
	water_bar = 100
