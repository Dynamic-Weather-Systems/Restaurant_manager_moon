extends Area2D


func _process(delta):
	var areas = get_overlapping_areas()
	for area in areas:
		if area.is_in_group("customer"):
			area.quench()
			queue_free()
