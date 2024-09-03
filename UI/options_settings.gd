extends Control


var music_settings = {
	'master_vol': 1,
	'sfx_vol': 1,
	'background_vol': 1
}


# Called when the node enters the scene tree for the first time.
func _ready():
	$master_volume.grab_focus()
	
	if not FileAccess.file_exists("res://saves/music_settings.save"):
		return
		
	var save_file = FileAccess.open("res://saves/music_settings.save", FileAccess.READ)
	while save_file.get_position() < save_file.get_length():
		var json_string = save_file.get_line()

		# Creates the helper class to interact with JSON
		var json = JSON.new()

		# Check if there is any error while parsing the JSON string, skip in case of failure
		var parse_result = json.parse(json_string)
		if not parse_result == OK:
			print("JSON Parse Error: ", json.get_error_message(), " in ", json_string, " at line ", json.get_error_line())
			continue

		# Get the data from the JSON object
		var music_settings = json.get_data()
		$master_volume.value = music_settings['master_vol']
		$sound_effects.value = music_settings['sfx_vol']
		$background_music.value = music_settings['background_vol']


## Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
	#print(music_settings)


func _on_master_volume_value_changed(value):
	$master_volume/value_text.text = str($master_volume.value * 100)
	music_settings['master_vol'] = $master_volume.value
	AudioServer.set_bus_volume_db(0, linear_to_db($master_volume.value))
	save_settings()


func _on_sound_effects_value_changed(value):
	$sound_effects/value_text.text = str($sound_effects.value * 100)
	music_settings['sfx_vol'] = $sound_effects.value
	AudioServer.set_bus_volume_db(2, linear_to_db($sound_effects.value))
	save_settings()


func _on_background_music_value_changed(value):
	$background_music/value_text.text = str($background_music.value * 100)
	music_settings['background_vol'] = $background_music.value
	AudioServer.set_bus_volume_db(1, linear_to_db($background_music.value))
	save_settings()


func save_settings():
	var save_file = FileAccess.open("res://saves/music_settings.save", FileAccess.WRITE)
	var json_string = JSON.stringify(music_settings)
	save_file.store_line(json_string)


func _on_button_pressed():
	get_node("/root/main_menu").set_process_mode(0)
	self.queue_free()
