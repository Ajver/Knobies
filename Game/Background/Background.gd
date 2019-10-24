extends ColorRect

export(float) var tween_duration

onready var knobs_manager = get_node("/root/Game").find_node("KnobsManager")
onready var change_color_tween = $ChangeColorTween

const COLORS : Array = [
	Color8(8, 68, 162),
	Color8(122, 230, 150),
	Color8(35, 107, 89),
	Color8(13, 119, 133),
	Color8(22, 66, 107),
	Color8(16, 54, 115),
	Color8(50, 13, 130),
	Color8(103, 7, 117),
	Color8(107, 56, 5),
	Color8(36, 84, 19),
]

var next_index : int = 1

func change_color() -> void:
	change_color_tween.interpolate_property(self, "modulate", modulate, COLORS[next_index], tween_duration, Tween.TRANS_LINEAR, Tween.EASE_IN_OUT)
	change_color_tween.start()
	next_index += 1

func _on_Knob_bought():
	if knobs_manager.get_child_count() >= next_index * 5:
		change_color()
	
