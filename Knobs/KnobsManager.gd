extends Position2D

var Knob = preload("res://Knobs/Knob.tscn")
var Hitter = preload("res://Knobs/Hitter/Hitter.tscn")

onready var game = get_node("/root/Game")
onready var screen_hit_audio = game.find_node("ScreenHitAudio")
	
func spawn_knob() -> void:
	var knob = Knob.instance()
	call_deferred("add_child", knob)

func _input(event) -> void:
	if event is InputEventScreenTouch and event.is_pressed():
		on_screen_hit(event.position)

func on_screen_hit(position) -> void:
	var hitter = Hitter.instance()
	game.call_deferred("add_child", hitter)
	hitter.call_deferred("hit", position, get_children())
	screen_hit_audio.play()

func on_load(knobs_pos_array:Array) -> void:
	for pos in knobs_pos_array:
		var knob = Knob.instance()
		add_child(knob)
		knob.global_position.x = pos.x
		knob.global_position.y = pos.y

func _on_Knob_bought():
	spawn_knob()
