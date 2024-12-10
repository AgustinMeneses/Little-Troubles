class_name levels extends Node3D
@onready var animation_player = $SpotLights/AnimationPlayer
@export var level_name : String
var can_animation : bool = true

# Called when the node enters the scene tree for the first time.
func _ready():
	add_to_group("levels")
	pass # Replace with function body.

func _on_area_3d_body_entered(body:CharacterBody3D):
	if body.is_in_group("Player") and can_animation:
		animation_player.play("SpotLights")
		can_animation = false
		await  animation_player.animation_finished
		$"Invisible wall".queue_free()
	pass # Replace with function body.

func level_completed(next_level : String):
	GameManager.level_completed(level_name)
	get_tree().change_scene_to_file(next_level)
	#get_tree().change_scene_to_file("res://Objects/rooms/staris_level.tscn")
