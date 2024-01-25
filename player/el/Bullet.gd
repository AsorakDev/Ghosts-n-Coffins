extends Area2D
class_name Bullet

func _physics_process(_delta):
	position.y -= 25

func _on_area_exited(_area):
	queue_free()

func _on_body_entered(_body):
	queue_free()
