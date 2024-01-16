extends Area2D
class_name RevolverTapProjectile

var acceleration : int = 0

func _physics_process(_delta):
	if acceleration >= -12:
		acceleration += -3
		
	position.y += acceleration

func _on_area_exited(area):
	delete()

func _on_body_entered(body):
	delete()

func delete():
	queue_free()
