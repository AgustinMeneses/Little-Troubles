extends Node3D
@onready var door = $door


# Called when the node enters the scene tree for the first time.
func _ready():
	$Control.visible = true
	$Control/Options.visible = false
	pass # Replace with function body.

func change():
	get_tree().change_scene_to_file("res://Objects/rooms/tutorial_level.tscn")
	pass

func _on_new_game_button_pressed():
	door.anim.play("open")
	$AnimationPlayer.play("Start - Continue")
	$Music2.volume_db = -18.0
	$Music.volume_db = -80.0
	pass # Replace with function body.
func _on_continue_button_pressed():
	$Control/Options.visible = true
	pass # Replace with function body.
func _on_exit_button_pressed():
	get_tree().quit()
	pass # Replace with function body.
func _on_music_2_finished():
	$Music.play()
	$Music2.play()
	pass # Replace with function body.
func _input(event):
	if Input.is_action_just_pressed("esc") and $Control/Options.visible:
		$Control/Options.visible= false
