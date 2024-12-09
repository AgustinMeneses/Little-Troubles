extends Control
@onready var option_buttons = $"Option Buttons"
@onready var label = $Label


# Called when the node enters the scene tree for the first time.
func _ready():
	visible = false
	$Options.visible = false
	pass # Replace with function body.

func _input(event):
	if Input.is_action_just_pressed("esc"):
		if not visible:
			get_tree().paused = true
			visible = true
			Input.mouse_mode=Input.MOUSE_MODE_VISIBLE


func _on_resume_button_pressed():
	get_tree().paused = false
	visible = false
	Input.mouse_mode=Input.MOUSE_MODE_CAPTURED
	pass # Replace with function body.


func _on_settings_button_pressed():
	$Options.visible = true
	option_buttons.modulate = Color(0.5,0.5,0.5)
	label.modulate = Color(0.5,0.5,0.5)
	pass # Replace with function body.


func _on_back_to_menu_button_pressed():
	get_tree().paused = false
	get_tree().change_scene_to_file("res://Objects/rooms/main_menu.tscn")
	pass # Replace with function body.


func _on_exit_button_pressed():
	get_tree().quit()
	pass # Replace with function body.
