extends Node

const KNOBS_COLORS = [
	Color8(255, 200, 3),
	Color8(8, 150, 3),
	Color8(242, 124, 5),
	Color8(30, 214, 205),
	Color8(151, 10, 240),
	Color8(194, 12, 179),
	Color8(191, 10, 88),
	Color8(183, 219, 22),
]

const KNOBS_SPRITES = [
	preload("res://Knobs/knob1.png"),
	preload("res://Knobs/knob2.png"),
	preload("res://Knobs/knob3.png")
]

static func get_random_knob_color() -> Color:
	return get_random_element_from_array(GameTheme.KNOBS_COLORS)
	
static func get_random_knob_sprite() -> Color:
	return get_random_element_from_array(GameTheme.KNOBS_SPRITES)
	
static func get_random_element_from_array(array:Array):
	var idx : int = randi() % array.size()
	return array[idx]