extends Area2D
class_name RevolverMashProjectile

var acceleration : int = 0

func _physics_process(_delta):
	if acceleration >= -10:
		acceleration += -2
		
	position.y += acceleration

func _on_area_exited(_area):
	delete()

func _on_body_entered(_body):
	delete()

func delete():
	queue_free()
