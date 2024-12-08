extends	StaticBody3D
@onready var anim = $AnimationPlayer
@onready var pick= $Sprite3D
var actual_state:String="closed"
var states:Array=["open","closed"]
var available:bool=true
var level_completed:bool=false

# Called when the node enters the scene tree for the first time.

func _input(_event):
	if Input.is_action_just_pressed("E") and pick.is_visible_in_tree() and available:
		if actual_state==states[1]:
			anim.play("open")
			actual_state=states[0]

func _on_close_the_door_body_entered(_body):
	if available:
		level_completed=true
		anim.play("close")
		available=false
		await anim.animation_finished
		pick.texture=null
	pass # Replace with function body.
