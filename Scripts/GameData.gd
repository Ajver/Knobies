extends Node
#class_name GameData

signal score_changed
signal knob_price_changed

var score : int = 100
var knob_price : int = 100
var hitter_radius : float = 50.0

static func add_score(additional_score:int) -> void:
	GameData.set_score(GameData.score + additional_score)
	
static func set_score(new_score:int) -> void:
	GameData.score = new_score
	GameData.emit_signal("score_changed")
	
static func can_buy_knob() -> bool:
	return GameData.score >= GameData.knob_price
	
static func on_knob_buy() -> void:
	GameData.add_score(-GameData.knob_price)
	GameData.knob_price = GameData.get_next_knob_price()
	GameData.hitter_radius *= 1.07
	GameData.emit_signal("knob_price_changed")

static func get_next_knob_price() -> int:
	var next_price : float = GameData.knob_price * 1.8
	if next_price < 1000:
		return int((next_price) / 10) * 10
	elif next_price < 1000000:
		return int((next_price) / 100) * 100
	elif next_price < 1000000000:
		return int((next_price) / 100000) * 100000
	else:
		return int((next_price) / 100000000) * 100000000
	
static func set_knob_price(knobs_count:int) -> void:
	for i in range(knobs_count):
		GameData.knob_price *= 2
	GameData.emit_signal("knob_price_changed")
	