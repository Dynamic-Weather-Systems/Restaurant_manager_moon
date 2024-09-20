extends CanvasLayer


var resume_tex = load("res://Assets/resume.png")
var pause_tex = load("res://Assets/pause.png")
var main_menu_tex = load("res://Assets/main_menu.png")

var resume_tex_hov = load("res://Assets/resume_hover.png")
var pause_hov = load("res://Assets/pause_hover.png")
var main_menu_hov = load("res://Assets/main_menu_hover.png")

var main_menu_scene = load('res://UI/main_menu.tscn')


# Called when the node enters the scene tree for the first time.
func _ready():
	$resume.hide()
	$main_menu_button.hide()


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if $resume.is_hovered():
		$resume.grab_focus()
	elif $main_menu_button.is_hovered():
		$main_menu_button.grab_focus()

	if $resume.has_focus():
		$resume.set_texture_normal(resume_tex_hov)
		$main_menu_button.set_texture_normal(main_menu_tex)
	elif $main_menu_button.has_focus():
		$main_menu_button.set_texture_normal(main_menu_hov)
		$resume.set_texture_normal(resume_tex)


func _on_resume_pressed():
	$main_menu_button.hide()
	$resume.hide()
	$pause.show()
	get_tree().paused = false


func _on_pause_pressed():
	$pause.hide()
	$resume.show()
	$main_menu_button.show()
	$resume.grab_focus()
	get_tree().paused = true


func _on_main_menu_button_pressed():
	get_tree().root.add_child(main_menu_scene.instantiate())
	get_tree().paused = false
	get_parent().queue_free()
	
