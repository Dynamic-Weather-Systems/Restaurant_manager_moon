extends Node2D


var main_scene = load('res://UI/main_menu.tscn')


# Called when the node enters the scene tree for the first time.
#func _ready():
	#pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
	#pass


func _on_button_pressed():
	get_node("/root/main_menu").set_process_mode(0)
	self.queue_free()
