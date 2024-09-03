extends Node


var music_settings = {
	'master_vol': 1,
	'background_vol': 1,
	'sfx_vol': 1
}


## Called when the node enters the scene tree for the first time.
func _ready():
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
		music_settings = json.get_data()
	
	AudioServer.set_bus_volume_db(0, linear_to_db(music_settings['master_vol']))
	AudioServer.set_bus_volume_db(2, linear_to_db(music_settings['sfx_vol']))
	AudioServer.set_bus_volume_db(1, linear_to_db(music_settings['background_vol']))


## Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
	#pass
