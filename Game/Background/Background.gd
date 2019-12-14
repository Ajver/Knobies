extends ColorRect

export(float) var tween_duration

onready var knobs_manager = get_node("/root/Game").find_node("KnobsManager")
onready var change_color_tween = $ChangeColorTween
onready var change_color_audio = $ChangeColorAudio

const COLORS : Array = [
	Color8(8, 68, 162),
	Color8(65, 171, 92),
	Color8(35, 107, 89),
	Color8(13, 119, 133),
	Color8(22, 66, 107),
	Color8(16, 54, 115),
	Color8(50, 13, 130),
	Color8(103, 7, 117),
	Color8(89, 48, 6),
	Color8(36, 84, 19),
]

var next_index : int = 1

func change_color() -> void:
	change_color_tween.interpolate_property(self, "color", color, COLORS[next_index], tween_duration, Tween.TRANS_LINEAR, Tween.EASE_IN_OUT)
	change_color_tween.start()
	next_index += 1
	change_color_audio.play()

func _on_Knob_bought() -> void:
	if next_index >= COLORS.size():
		return
		
	if knobs_manager.get_child_count() >= next_index * 5 - 1:
		change_color()
	
func set_next_index(value:int) -> void:
	next_index = value
	color = COLORS[next_index-1]