extends Node
#class_name GameData

signal score_changed
signal knob_price_changed

var score : int = 0
var knob_price : int = 100

static func add_score(additional_score:int) -> void:
	GameData.score += additional_score
	GameData.emit_signal("score_changed")
	
static func can_buy_knob() -> bool:
	return GameData.score >= GameData.knob_price
	
static func on_knob_buy() -> void:
	GameData.add_score(-GameData.knob_price)
	GameData.knob_price *= 2
	GameData.emit_signal("knob_price_changed")
	
	