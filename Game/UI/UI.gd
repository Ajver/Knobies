extends Node2D

onready var buy_knob_btn = find_node("BuyKnobBtn")
onready var score_label = find_node("Score")
onready var knob_price_label = find_node("KnobPrice")
onready var knobs_manager = get_node("/root/Game").find_node("KnobsManager")

var buy_knob_btn_normal = preload("res://Game/UI/buy_knob_btn.png")
var buy_knob_btn_pressed = preload("res://Game/UI/buy_knob_btn_pressed.png")
var buy_knob_btn_disabled = preload("res://Game/UI/buy_knob_btn_disabled.png")

func _ready():
	GameData.connect("knob_price_changed", self, "update_knob_price_label")
	GameData.connect("score_changed", self, "on_score_changed")
	GameData.connect("score_changed", self, "update_score_label")

func on_score_changed() -> void:
	if GameData.can_buy_knob():
		buy_knob_btn.normal = buy_knob_btn_normal
		buy_knob_btn.pressed = buy_knob_btn_pressed
	else:
		buy_knob_btn.normal = buy_knob_btn_disabled
		buy_knob_btn.pressed = null

func update_score_label() -> void:
	score_label.text = make_string(GameData.score)
	
func update_knob_price_label() -> void:
	knob_price_label.text = make_string(GameData.knob_price)

func make_string(number:int) -> String:
	if number < 1000:
		return str(number)
	elif number < 1000000:
		return str(stepify(number/1000.0, 0.1), "k")
	else:
		return str(stepify(number/1000000.0, 0.1), "m")

func _on_BuyKnobBtn_released():
	if GameData.can_buy_knob():
		GameData.on_knob_buy()
		knobs_manager.spawn_knob()
