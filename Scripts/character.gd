class_name Player extends CharacterBody3D

var fuerza:float=5
#var object=null
var object:Array[RigidBody3D]=[]
var flashlight : StaticBody3D
var is_picked_up=false
const walk_speed=5.5
const sprint_speed= 9
var speed

var can_move : bool = true
var is_small : bool = false
@export var JUMP_VELOCITY = 4
@export var sensiblidad:float=0.01

@onready var anim = $AnimationPlayer
@onready var head = $MeshInstance3D
@onready var self_marker = $"PickUp Marker"
@onready var lintern_marker = $"Lintern Marker"
@onready var ray_cast: RayCast3D = $RayCast3D
@onready var ui: UI_CONTROL = $CanvasLayer/UI


enum states {chiquito , normal}
var stados = states.normal
# Get the gravity from the project settings to be synced with RigidBody nodes.
var gravity = ProjectSettings.get_setting("physics/3d/default_gravity")

func _ready():
	add_to_group("Player")
	Input.mouse_mode=Input.MOUSE_MODE_CAPTURED
	$Min.emitting = false
	$Max.emitting = false
	$"CanvasLayer/UI/Options".visible = false
	$CanvasLayer/UI/Messages/Label.visible = false
	$"CanvasLayer/UI/Options".general.value = AudioServer.get_bus_volume_db(0)
	$"CanvasLayer/UI/Options".effects.value = AudioServer.get_bus_volume_db(1)
	$"CanvasLayer/UI/Options".music.value = AudioServer.get_bus_volume_db(2)
	pass

func _physics_process(delta):
	# Add the gravity.
	if not is_on_floor():
		velocity.y -= gravity * delta
	# Handle jump.
	if can_move:	
		if Input.is_action_just_pressed("ui_accept") and is_on_floor():
			$sounds/jump.play()
			if stados == states.normal:
				var random_pitch = randf_range(0.8 , 1.2)
				$"sounds/jump grunt".pitch_scale = random_pitch
			else:
				var random_pitch = randf_range(1.9 , 2.2)
				$"sounds/jump grunt".pitch_scale = random_pitch
			$"sounds/jump grunt".play()
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
			if speed == walk_speed and is_on_floor() and not is_on_wall():
				anim.play("walking")
			elif speed == sprint_speed and is_on_floor() and not is_on_wall():
				anim.play("sprint")
			else:
				anim.pause()
		else:
			anim.pause()
			velocity.x = 0.0
			velocity.z = 0.0
	else:
		velocity.x = 0.0
		velocity.z = 0.0
	move_and_slide()

func _on_pick_up_area_body_entered(body):
	body.pick.visible=true
	if body.is_in_group("objetos"):
		object.append(body)
	elif body.is_in_group("flashlight"):
		flashlight = body
	pass # Replace with function body
func _on_pick_up_area_body_exited(body):
	if body.pick != null:
		body.pick.visible= false
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
		object.front()._picked_up(self_marker, self)
		is_picked_up=true
	if Input.is_action_just_pressed("E") and flashlight:
		if flashlight.pick != null:
			flashlight._picked_up(lintern_marker)
	if event is InputEventMouseMotion:
		rotate_object_local(Vector3.UP,event.relative.x* -0.01)

func _size(size:String):
	if size == "small" and not is_small:
		stados = states.chiquito
		anim.play("Normal_to_small")
		if flashlight:
			flashlight._change_colors("smol")
		is_small = true
		can_move = false
		await anim.animation_finished
		can_move = true
	elif size == "normal" and is_small:
		stados = states.normal
		anim.play("small_to_normal")
		if flashlight:
			flashlight._change_colors("big")
		is_small = false
		can_move = false
		await anim.animation_finished
		can_move = true

func _text(text:String):
	$CanvasLayer/UI.show_text(text)
