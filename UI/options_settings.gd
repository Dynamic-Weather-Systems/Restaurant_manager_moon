extends Control


## Called when the node enters the scene tree for the first time.
#func _ready():
	#pass # Replace with function body.


## Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
	#pass


func _on_master_volume_value_changed(value):
	$master_volume/value_text.text = str($master_volume.value * 100)
	AudioServer.set_bus_volume_db(0, linear_to_db($master_volume.value))


func _on_sound_effects_value_changed(value):
	$sound_effects/value_text.text = str($sound_effects.value * 100)
	AudioServer.set_bus_volume_db(2, linear_to_db($sound_effects.value))


func _on_background_music_value_changed(value):
	$background_music/value_text.text = str($background_music.value * 100)
	AudioServer.set_bus_volume_db(1, linear_to_db($background_music.value))


func _on_gun_finished():
	$gun.play()


func _on_guitar_finished():
	$guitar.play()
