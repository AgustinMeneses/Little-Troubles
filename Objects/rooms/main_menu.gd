extends Node3D
@onready var door = $door


# Called when the node enters the scene tree for the first time.
func _ready():
	$Control.visible = true
	pass # Replace with function body.

func change():
	get_tree().change_scene_to_file("res://Objects/rooms/tutorial_level.tscn")
	pass

func _on_new_game_button_pressed():
	door.anim.play("open")
	$AnimationPlayer.play("Start - Continue")
	pass # Replace with function body.

func _on_continue_button_pressed():
	door.anim.play("open")
	$AnimationPlayer.play("Start - Continue")
	pass # Replace with function body.

func _on_exit_button_pressed():
	get_tree().quit()
	pass # Replace with function body.