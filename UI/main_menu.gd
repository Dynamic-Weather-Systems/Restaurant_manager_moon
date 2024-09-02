extends Control

var continue_tex = load("res://Assets/continue.png")
var new_game_tex = load("res://Assets/new_game.png")
var options_tex = load("res://Assets/options.png")
var credits_tex = load("res://Assets/credits.png")

var continue_tex_hov = load("res://Assets/continue_hover.png")
var new_game_tex_hov = load("res://Assets/new_game_hover.png")
var options_tex_hov = load("res://Assets/options_hover.png")
var credits_tex_hov = load("res://Assets/credits_hover.png")

var level_scene = load('res://test_level/layout_3.tscn').instantiate()
var credit_scene = load('res://UI/credits_scene.tscn').instantiate()
var options_scene = load('res://UI/options_settings.tscn').instantiate()

# Called when the node enters the scene tree for the first time.
func _ready():
	$continue_button.grab_focus()


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if $continue_button.has_focus():
		$continue_button.set_texture_normal(continue_tex_hov)
		$new_game.set_texture_normal(new_game_tex)
		$options.set_texture_normal(options_tex)
		$credits.set_texture_normal(credits_tex)
	elif $new_game.has_focus():
		$continue_button.set_texture_normal(continue_tex)
		$new_game.set_texture_normal(new_game_tex_hov)
		$options.set_texture_normal(options_tex)
		$credits.set_texture_normal(credits_tex)
	elif $options.has_focus():
		$continue_button.set_texture_normal(continue_tex)
		$new_game.set_texture_normal(new_game_tex)
		$options.set_texture_normal(options_tex_hov)
		$credits.set_texture_normal(credits_tex)
	elif $credits.has_focus():
		$continue_button.set_texture_normal(continue_tex)
		$new_game.set_texture_normal(new_game_tex)
		$options.set_texture_normal(options_tex)
		$credits.set_texture_normal(credits_tex_hov)


func _on_continue_button_pressed():
	get_tree().root.add_child(level_scene)
	self.queue_free()


func _on_new_game_pressed():
	get_tree().root.add_child(level_scene)
	self.queue_free()


func _on_options_pressed():
	get_tree().root.add_child(options_scene)


func _on_credits_pressed():
	get_tree().root.add_child(credit_scene)
	self.queue_free()


func _on_continue_area_mouse_entered():
	$continue_button.grab_focus()


func _on_new_game_area_mouse_entered():
	$new_game.grab_focus()


func _on_options_area_mouse_entered():
	$options.grab_focus()


func _on_credits_area_mouse_entered():
	$credits.grab_focus()


func _on_guitar_finished():
	$guitar.play()


func _on_gun_finished():
	$gun.play()
