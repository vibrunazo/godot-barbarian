class_name Bank
extends MarginContainer

@export var starting_gold: float = 250
@onready var gold_label: Label = $GoldLabel

var gold: float:
	set(value):
		gold = max(0, value)
		if gold_label:
			gold_label.text = "gold: %s" % gold

func _ready() -> void:
	gold = starting_gold
