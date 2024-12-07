extends Panel
class_name settings
@onready var music = $Music
@onready var effects = $Effects
@onready var general = $General

@export var can_press_esc : bool = true
func _on_general_value_changed(value):
	AudioServer.set_bus_volume_db(0, value)
	pass # Replace with function body.


func _on_effects_value_changed(value):
	AudioServer.set_bus_volume_db(1, value)
	pass # Replace with function body.


func _on_music_value_changed(value):
	AudioServer.set_bus_volume_db(2, value)
	pass # Replace with function body.

func _input(event):
	if Input.is_action_just_pressed("esc") and can_press_esc:
		if visible:
			get_tree().paused = false
			visible = false
			Input.mouse_mode=Input.MOUSE_MODE_CAPTURED
		elif not visible:
			get_tree().paused = true
			Input.mouse_mode=Input.MOUSE_MODE_VISIBLE
			visible = true
