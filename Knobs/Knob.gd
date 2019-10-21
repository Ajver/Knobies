extends RigidBody2D

var max_speed = 200
var max_speed_sqr = max_speed*max_speed

func _ready():
	var sprite = get_node("Sprite")
	sprite.texture = GameTheme.get_random_knob_sprite()
	sprite.modulate = GameTheme.get_random_knob_color()

func on_hit(force:Vector2) -> void:
	apply_central_impulse(force)
	fix_velocity()
	
func fix_velocity() -> void:
	if get_linear_velocity().length_squared() > max_speed_sqr:
		var new_velocity = get_linear_velocity().normalized() * max_speed
		set_linear_velocity(new_velocity)