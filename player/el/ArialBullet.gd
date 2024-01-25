extends Area2D
class_name ArialBulelt
 
var ammount : int 
var rng : int
var acceleration : float = 80

func _ready():
	rng = randi_range(-5, 5)
	rotation_degrees = rng

func _physics_process(_delta):
	handle_speed()
	handle_angle()

func handle_speed():
	position.y += acceleration
	if acceleration > 40:
		acceleration -= 5

func handle_angle():
	position.x -= rng

func _on_area_entered(_area):
	print("ENTERED")

func _on_body_entered(body):
	queue_free()
