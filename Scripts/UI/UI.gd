extends Control
@onready var option_buttons = $"Option Buttons"
@onready var label = $"Label"
@onready var options: settings = $"Options"
@onready var anim: AnimationPlayer = $AnimationPlayer


# Called when the node enters the scene tree for the first time.
func _ready():
	option_buttons.visible = false
	label.visible = false
	options.visible = false
	pass # Replace with function body.

func _input(_event):
	if Input.is_action_just_pressed("esc"):
		if not option_buttons.visible:
			get_tree().paused = true
			option_buttons.visible = true
			label.visible =true
			Input.mouse_mode=Input.MOUSE_MODE_VISIBLE

func show_text(text):
	$Messages/Label.text = str(text)
	$Messages/Label.visible = true
	anim.play("show text")
	await anim.animation_finished
	$Messages/Label.visible = false
func _on_resume_button_pressed():
	get_tree().paused = false
	option_buttons.visible = false
	label.visible = false
	Input.mouse_mode=Input.MOUSE_MODE_CAPTURED
	pass # Replace with function body.


func _on_settings_button_pressed():
	options.visible = true
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
