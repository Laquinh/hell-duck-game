extends CanvasLayer

var bus_index: int
var is_paused: bool = false

func _input(event: InputEvent) -> void:
	bus_index = AudioServer.get_bus_index("Master")
	if event.is_action_pressed("ui_cancel"):
		toggle_pause()

func toggle_pause() -> void:
	is_paused = !is_paused
	get_tree().paused = is_paused
	visible = is_paused

func _on_resume_button_pressed() -> void:
	toggle_pause()

func _on_quit_button_pressed() -> void:
	get_tree().quit()

func _on_volume_slider_value_changed(value: float) -> void:
	AudioServer.set_bus_volume_db(bus_index, linear_to_db(value))
