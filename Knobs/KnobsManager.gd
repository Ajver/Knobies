extends Position2D

var Knob = preload("res://Knobs/Knob.tscn")
var Hitter = preload("res://Knobs/Hitter.tscn")

onready var game = get_node("/root/Game")
onready var ui = game.find_node("UI")

func _ready() -> void:
	spawn_knob()
	
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
