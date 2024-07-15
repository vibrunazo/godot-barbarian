## UI Autoload with UI related globals
extends Node


func _unhandled_key_input(event: InputEvent) -> void:
	if event.is_action_pressed("ui_fullscreen"):
		toggle_fullscreen()
	if event.is_action_pressed("ui_cancel"):
		get_tree().quit()
	if event.is_action_pressed("toggle_speed"):
		toggle_speed()
		
func is_fullscreen() -> bool:
	return DisplayServer.window_get_mode() == DisplayServer.WINDOW_MODE_EXCLUSIVE_FULLSCREEN or DisplayServer.window_get_mode() == DisplayServer.WINDOW_MODE_FULLSCREEN

func go_fullscreen() -> void:
	DisplayServer.window_set_mode(DisplayServer.WINDOW_MODE_EXCLUSIVE_FULLSCREEN)
	
func toggle_fullscreen() -> void:
	if is_fullscreen():
		DisplayServer.window_set_mode(DisplayServer.WINDOW_MODE_WINDOWED)
	else:
		go_fullscreen()

func toggle_speed() -> void:
	if Engine.time_scale == 1:
		Engine.time_scale = 3
	else:
		Engine.time_scale = 1
