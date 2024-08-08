extends CanvasLayer


# Called when the node enters the scene tree for the first time.
func _ready():
	$resume.hide()


# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
	#pass


func _on_resume_pressed():
	$resume.hide()
	get_tree().paused = false


func _on_pause_pressed():
	get_tree().paused = true
	$resume.show()
