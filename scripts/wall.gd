extends StaticBody2D


func hit():
	
	var frame = $AnimatedSprite2D.frame

	if frame >= 4:
		queue_free()
		
	$AnimatedSprite2D.frame += 1
