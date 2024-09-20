extends Node2D

var back_tex = load("res://Assets/back.png")
var back_tex_hov = load("res://Assets/back_hover.png")

var main_scene = load('res://UI/main_menu.tscn')


# Called when the node enters the scene tree for the first time.
func _ready():
	$Button.grab_focus()


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if $Button.is_hovered():
		$Button.grab_focus()
	
	if $Button.has_focus():
		$Button.set_texture_normal(back_tex_hov)
	else :
		$Button.set_texture_normal(back_tex)


func _on_button_pressed():
	get_node("/root/main_menu").set_process_mode(0)
	self.queue_free()
