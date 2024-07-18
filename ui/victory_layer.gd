class_name VictoryLayer
extends CanvasLayer

@onready var star_container: HBoxContainer = %StarContainer
@onready var base: Base = get_tree().get_first_node_in_group("base")
@onready var bank: Bank = get_tree().get_first_node_in_group("bank")
@onready var survived_label: Label = %SurvivedLabel
@onready var fullhealth_label: Label = %FullhealthLabel
@onready var money_label: Label = %MoneyLabel


func victory() -> void:
	show()
	survived_label.show()
	var stars: int = 1
	if base.health == base.max_health:
		stars += 1
		fullhealth_label.show()
	if bank.gold >= 500:
		stars += 1
		money_label.show()
	var awarded: int = 0
	for star in star_container.get_children():
		if star is TextureRect:
			if awarded >= stars: break
			star.modulate = Color.WHITE
			awarded += 1
		
	

func _on_retry_button_pressed() -> void:
	get_tree().reload_current_scene()
	

func _on_quit_button_pressed() -> void:
	get_tree().quit()
