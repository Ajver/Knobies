extends Node2D

export(Color) var start_color
export(Color) var end_color

onready var hit_area_sprite = $HitAreaSprite
onready var scale_tween = $ScaleTween
onready var alpha_tween = $AlphaTween

var radius : float = 50
var radius_sqr : float = radius * radius
var strength : float = 1000

func hit(hit_position:Vector2, knobs_array:Array) -> void:
	global_position = hit_position
	run_animations()
	
	var knobs_in_range : Array = []
	
	for knob in knobs_array:
		var diff : Vector2 = knob.global_position - hit_position
		var dist_sqr : float = diff.length_squared()
		if dist_sqr <= radius_sqr:
			dist_sqr = max(dist_sqr, 1.0)
				
			var hit_str : float = strength / sqrt(dist_sqr)
			var force_vector : Vector2 = diff.normalized() * hit_str
			
			knobs_in_range.push_back({0:knob, 1:force_vector})
			
	for knob_dict in knobs_in_range:
		var knob = knob_dict[0]
		var force_vector = knob_dict[1]
		knob.on_hit(force_vector * knobs_in_range.size())
		
	GameData.add_score(knobs_in_range.size() * knobs_in_range.size() * 10)
				
func run_animations() -> void:
	var animation_duration = 0.2;
	var texture_width : float = hit_area_sprite.texture.get_width()
	var target_sprite_scale : float = radius / texture_width
	
	alpha_tween.interpolate_property(self, "modulate", start_color, end_color, animation_duration, Tween.TRANS_LINEAR, Tween.EASE_OUT)
	alpha_tween.start()
	
	scale_tween.interpolate_property(hit_area_sprite, "scale", Vector2(0, 0), Vector2(target_sprite_scale, target_sprite_scale), animation_duration, Tween.TRANS_LINEAR, Tween.EASE_OUT)
	scale_tween.start()
	
func _on_Tween_tween_all_completed():
	queue_free()
