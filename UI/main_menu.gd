extends Control


var new_game_tex = load("res://Assets/new_game.png")
var options_tex = load("res://Assets/options.png")
var credits_tex = load("res://Assets/credits.png")

var new_game_tex_hov = load("res://Assets/new_game_hover.png")
var options_tex_hov = load("res://Assets/options_hover.png")
var credits_tex_hov = load("res://Assets/credits_hover.png")

var level_scene = load('res://test_level/layout_3.tscn')
var credit_scene = load('res://UI/credits_scene.tscn')
var options_scene = load('res://UI/options_settings.tscn')

# Called when the node enters the scene tree for the first time.
func _ready():
	$new_game.grab_focus()


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if $new_game.is_hovered():
		$new_game.grab_focus()
	elif $options.is_hovered():
		$options.grab_focus()
	elif $credits.is_hovered():
		$credits.grab_focus()

	if $new_game.has_focus():
		$new_game.set_texture_normal(new_game_tex_hov)
		$options.set_texture_normal(options_tex)
		$credits.set_texture_normal(credits_tex)
	elif $options.has_focus():
		$new_game.set_texture_normal(new_game_tex)
		$options.set_texture_normal(options_tex_hov)
		$credits.set_texture_normal(credits_tex)
	elif $credits.has_focus():
		$new_game.set_texture_normal(new_game_tex)
		$options.set_texture_normal(options_tex)
		$credits.set_texture_normal(credits_tex_hov)


func _on_new_game_pressed():
	get_tree().root.add_child(level_scene.instantiate())
	self.queue_free()


func _on_options_pressed():
	get_tree().root.add_child(options_scene.instantiate())
	self.set_process_mode(4)


func _on_credits_pressed():
	get_tree().root.add_child(credit_scene.instantiate())
	self.queue_free()


func _on_guitar_finished():
	$guitar.play()


func _on_gun_finished():
	$gun.play()
