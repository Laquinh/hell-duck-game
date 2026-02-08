extends Control

func _start_game():
	get_tree().change_scene_to_file('res://main.tscn')

func _quit_game():
	get_tree().quit()
