extends levels
var timer = 100
var player = UI_CONTROL
func _ready() -> void:
	$"Labels/Door Trap label".visible = false

func _on_door_area_trap_body_entered(body: Player) -> void:
	player = body.ui
	pass # Replace with function body.

func text_animation():
	$Labels/AnimationPlayer.play("horror text")
	await $Labels/AnimationPlayer.animation_finished
	player.timer.visible = true
	$TIMER.start()

func _on_timer_timeout() -> void:
	timer -= 1
	player._timer(timer)
	if timer == 0:
		get_tree().change_scene_to_file("res://Objects/rooms/main_menu.tscn")
	$TIMER.start()
	pass # Replace with function body.

func level_completed(next_level : String):
	GameManager.level_completed(level_name)
	get_tree().change_scene_to_file(next_level)
