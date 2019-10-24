extends Control

onready var game_saver = $GameSaver

func _ready():
	game_saver.load_save()
	randomize()
	
func _input(event):
	if Input.is_action_just_pressed("exit_game"):
		get_tree().quit()
