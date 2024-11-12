extends CharacterBody3D

var fuerza:float=5
var object=null
var is_picked_up=false

const walk_speed=7.0
const sprint_speed= 15.0
var speed
 
@export var JUMP_VELOCITY = 4
@export var sensiblidad:float=0.01

@onready var head = $MeshInstance3D
@onready var camera:Camera3D = $MeshInstance3D/Camera3D
@onready var self_marker = $Marker3D

# Get the gravity from the project settings to be synced with RigidBody nodes.
var gravity = ProjectSettings.get_setting("physics/3d/default_gravity")

func _ready():
	Input.mouse_mode=Input.MOUSE_MODE_CAPTURED
	pass

func _physics_process(delta):
	# Add the gravity.
	if not is_on_floor():
		velocity.y -= gravity * delta

	# Handle jump.
	if Input.is_action_just_pressed("ui_accept") and is_on_floor():
		velocity.y = JUMP_VELOCITY
	
	if Input.is_action_pressed("Shift"):
		speed = sprint_speed
	else:
		speed= walk_speed
	
	var input_dir = Input.get_vector("ui_left", "ui_right", "ui_up", "ui_down")
	var direction = (transform.basis * Vector3(input_dir.x, 0, input_dir.y)).normalized()
	if direction:
		velocity.x = direction.x * speed
		velocity.z = direction.z * speed
	else:
		velocity.x = 0.0
		velocity.z = 0.0
	move_and_slide()

func _process(delta):
	if object==null: return
	var marker:Marker3D=object.marker_3d
	var sprite:Sprite2D=object.pick
	var screen_pos=camera.unproject_position(marker.global_transform.origin)
	sprite.position=screen_pos
	pass

func _on_pick_up_area_body_entered(body:RigidBody3D):
	body.pick.visible=true
	object=body
	pass # Replace with function body
func _on_pick_up_area_body_exited(body):
	body.pick.visible=false
	if not body.collision.disabled:
		object=null
	pass # Replace with function body.

func _input(event):
	if Input.is_action_just_pressed("E") and object!=null:
		if object.collision.disabled:
			object.dropped_off()
			is_picked_up=false
			return
		object._picked_up(self_marker)
		is_picked_up=true
	if event is InputEventMouseMotion:
		rotate_object_local(Vector3.UP,event.relative.x* -0.01)
