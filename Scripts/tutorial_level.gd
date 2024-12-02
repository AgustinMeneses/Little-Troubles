extends Node3D
@onready var animation_player = $SpotLights/AnimationPlayer

var can_animation : bool = true

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass


func _on_area_3d_body_entered(body:CharacterBody3D):
	if body.is_in_group("Player") and can_animation:
		#$Escape.visible = true
		animation_player.play("SpotLights")
		can_animation = false
		await  animation_player.animation_finished
		$"Invisible wall".queue_free()
	pass # Replace with function body.
