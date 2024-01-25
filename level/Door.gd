extends Area2D
class_name Door01

@onready var camera_2d = $Camera2D
@onready var label = $Label
@onready var player : Player = $"../../El"
var on_door : bool = false

func _physics_process(_delta):
	if on_door:
		player.can_jump = false
		
		if Input.is_action_just_pressed("up"):
			$Timer.start()
			
		if Input.is_action_pressed("up"):
			camera_2d.zoom += Vector2(.01, .01)
			camera_2d.position.y += 4
			label.modulate = "blue"
		
		if Input.is_action_just_released("up"):
			camera_2d.zoom = Vector2(1, 1)
			camera_2d.position = Vector2(960, 720)
			label.modulate = "white"
			$Timer.stop()
	
	elif not on_door:
		player.can_jump = true
		camera_2d.zoom = Vector2(1, 1)
		camera_2d.position = Vector2(960, 720)
		label.modulate = "white"
		$Timer.stop()
		
func _on_body_entered(_body):
	on_door = true
	label.visible = true

func _on_body_exited(_body):
	on_door = false
	label.visible = false

func _on_timer_timeout():
	get_tree().change_scene_to_file("res://level/debug_level_1.tscn")
	
