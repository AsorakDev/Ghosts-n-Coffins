extends StaticBody2D

func _process(_delta):
	pass

func _on_timer_timeout():
	$CollisionShape2D.disabled = not $CollisionShape2D.disabled
	$Sprite2D.visible = not $Sprite2D.visible
