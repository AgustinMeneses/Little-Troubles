extends CharacterBody3D

var fuerza:float=5
#var object=null
var object:Array[RigidBody3D]=[]
var is_picked_up=false

const walk_speed=7.0
const sprint_speed= 15.0
var speed
 
var is_small : bool = false
@export var JUMP_VELOCITY = 4
@export var sensiblidad:float=0.01

@onready var anim = $AnimationPlayer
@onready var head = $MeshInstance3D
@onready var camera:Camera3D = $MeshInstance3D/Camera3D
@onready var self_marker = $"PickUp Marker"

# Get the gravity from the project settings to be synced with RigidBody nodes.
var gravity = ProjectSettings.get_setting("physics/3d/default_gravity")

func _ready():
	add_to_group("Player")
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

func _on_pick_up_area_body_entered(body):
	body.pick.visible=true
	if body.is_in_group("objetos"):
		object.append(body)
	pass # Replace with function body
func _on_pick_up_area_body_exited(body):
	body.pick.visible=false
	if body.is_in_group("objetos"):
		if not body.collision.disabled:
			object.erase(body)
	pass # Replace with function body.

func _input(event):
	if Input.is_action_just_pressed("E") and object.size()!=0:
		if object.front().collision.disabled:
			object.front().dropped_off()
			object.erase(object.front())
			is_picked_up=false
			return
		object.front()._picked_up(self_marker)
		is_picked_up=true
	if event is InputEventMouseMotion:
		rotate_object_local(Vector3.UP,event.relative.x* -0.01)

func _size(size:String):
	if size == "small" and not is_small:
		anim.play("Normal_to_small")
		$Min.emitting = true
		is_small = true
	elif size == "normal" and is_small:
		anim.play("small_to_normal")
		$Max.emitting = true
		is_small = false
	else:
		print(head.scale.x)
		$Min.emitting = false
		$Max.emitting = false
