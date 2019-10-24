extends Node

const SAVE_PATH : String = "user://knobies.data"

onready var game = get_node("/root/Game")
onready var knobs_manager = game.find_node("KnobsManager")
onready var next_save_timer = $NextSaveTimer
onready var background = game.find_node("Background")

func save_game() -> void:
	var data = get_data_to_save()
	var f = File.new()
	f.open(SAVE_PATH, File.WRITE)
	f.store_line(to_json(data))
	f.close()
	
func get_data_to_save() -> Dictionary:
	var data : Dictionary = {
		"score": GameData.score,
		"hitter_radius": GameData.hitter_radius,
		"next_background_index": background.next_index,
		"knobs_array": []
	}
	
	var knobies_pos_array : Array = []
	knobies_pos_array.resize(knobs_manager.get_child_count())
	
	var i : int = 0
	for knob in knobs_manager.get_children():
		knobies_pos_array[i] = { 
			"x": knob.global_position.x,
			"y": knob.global_position.y
		}
		i += 1
		
	data["knobs_array"] = knobies_pos_array
	
	return data
	
func load_save():
	var f = File.new()
	
	if not f.file_exists(SAVE_PATH):
		return
		
	f.open(SAVE_PATH, File.READ)
	var data = JSON.parse(f.get_as_text()).result
	f.close()
	
	if data:
		load_variables(data)
	
func load_variables(data:Dictionary) -> void:
	GameData.set_score(int(data["score"]))
	GameData.hitter_radius = float(data["hitter_radius"])
	GameData.set_knob_price(data["knobs_array"].size())
	knobs_manager.on_load(data["knobs_array"])
	background.set_next_index(int(data["next_background_index"]))
	
func _on_NextSaveTimer_timeout():
	save_game()

func _on_Knob_bought():
	call_deferred("save_game")
	next_save_timer.start()