extends Position2D

var Knob = preload("res://Knobs/Knob.tscn")

func _ready():
	spawn_knob()
	
func spawn_knob():
	var knob = Knob.instance()
	call_deferred("add_child", knob)

func _input(event):
	if event is InputEventScreenTouch and event.is_pressed():
		screen_hit(event.position)

func screen_hit(position):
	
	print(position)