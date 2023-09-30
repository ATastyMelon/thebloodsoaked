extends Node

func loading_screen_goto(target: String):
	var loading_screen = preload("res://Scenes/loading_screen.tscn").instantiate()
	loading_screen.next_scene_path = target
	get_tree().current_scene.add_child(loading_screen)
	
func loading_screen_goto_mainnmenu(target: String):
	var loading_screen = preload("res://Scenes/mm_loading_screen.tscn").instantiate()
	loading_screen.next_scene_path = target
	get_tree().current_scene.add_child(loading_screen)
