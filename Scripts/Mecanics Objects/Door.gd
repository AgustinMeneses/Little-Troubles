extends	StaticBody3D
@export var next_level : String
@onready var anim = $AnimationPlayer
@onready var pick= $Sprite3D
var actual_state:String="closed"
var states:Array=["open","closed"]
var available:bool=true
# Called when the node enters the scene tree for the first time.
func _input(_event):
	if Input.is_action_just_pressed("E") and pick.is_visible_in_tree() and available:
		if actual_state==states[1]:
			anim.play("open")
			actual_state=states[0]

func _on_close_the_door_body_entered(body):
	if available and body.is_in_group("Player"):
		anim.play("close")
		available=false
		await anim.animation_finished
		pick.texture=null
		get_parent().level_completed(next_level)
	pass # Replace with function body.
