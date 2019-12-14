extends AudioStreamPlayer

func play(from_position:float = 0.0) -> void:
	if not playing:
		.play(from_position)
		