extends Control

func _ready():
	Input.set_mouse_mode(Input.MOUSE_MODE_VISIBLE)

func _on_play_pressed():
	Functions.loading_screen_goto("res://Scenes/Game.tscn")

func _on_quit_pressed():
	get_tree().quit()
