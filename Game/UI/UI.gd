extends Node2D

onready var score_label = find_node("Score")
onready var knob_price_label = find_node("KnobPrice")
onready var knobs_manager = get_node("/root/Game").find_node("KnobsManager")

func _ready():
	GameData.connect("knob_price_changed", self, "update_knob_price_label")
	GameData.connect("score_changed", self, "update_score_label")

func update_score_label() -> void:
	score_label.text = make_string(GameData.score)
	
func update_knob_price_label() -> void:
	knob_price_label.text = make_string(GameData.knob_price)

func make_string(number:int) -> String:
	if number < 1000:
		return str(number)
	elif number < 1000000:
		return str(floor(number/100)/10.0, "k")
	else:
		return str(floor(number/100000)/10.0, "m")

func _on_BuyKnobBtn_pressed():
	if GameData.can_buy_knob():
		GameData.on_knob_buy()
		knobs_manager.spawn_knob()
