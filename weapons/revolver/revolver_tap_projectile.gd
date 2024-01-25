extends Area2D
class_name RevolverTapProjectile

func _physics_process(_delta):
	position.y -= 10

func _on_area_exited(area):
	delete()

func _on_body_entered(body):
	delete()

func delete():
	queue_free()
