extends Node2D

signal knob_bought

onready var buy_knob_btn = find_node("BuyKnobBtn")
onready var score_label = find_node("Score")
onready var knob_price_label = find_node("KnobPrice")
onready var knobs_manager = get_node("/root/Game").find_node("KnobsManager")

var buy_knob_btn_normal = preload("res://Game/UI/buy_knob_btn.png")
var buy_knob_btn_pressed = preload("res://Game/UI/buy_knob_btn_pressed.png")
var buy_knob_btn_disabled = preload("res://Game/UI/buy_knob_btn_disabled.png")

func _ready():
	GameData.connect("knob_price_changed", self, "update_knob_price_label")
	GameData.connect("score_changed", self, "update_score_label")
	GameData.connect("knob_price_changed", self, "update_knob_btn_avability")
	GameData.connect("score_changed", self, "update_knob_btn_avability")
	
	update_score_label()
	update_knob_price_label()
	update_knob_btn_avability()

func update_knob_btn_avability() -> void:
	if GameData.can_buy_knob():
		buy_knob_btn.normal = buy_knob_btn_normal
		buy_knob_btn.pressed = buy_knob_btn_pressed
	else:
		buy_knob_btn.normal = buy_knob_btn_disabled
		buy_knob_btn.pressed = null

func update_score_label() -> void:
	score_label.text = make_string(GameData.score, 0.01)
	
func update_knob_price_label() -> void:
	knob_price_label.text = make_string(GameData.knob_price, 0.1)

func make_string(number:int, step:float) -> String:
	if number < 1000:
		return str(number)
	elif number < 1000000:
		return str(stepify(number/1000.0, step), "k")
	elif number < 1000000000:
		return str(stepify(number/1000000.0, step), "m")
	else:
		return str(stepify(number/1000000000.0, step), "g")

func _on_BuyKnobBtn_released():
	if GameData.can_buy_knob():
		emit_signal("knob_bought")
		GameData.on_knob_buy()
