# Enemy.gd
extends RigidBody2D

func _on_area_2d_body_entered(body):
	if body.name == "CharacterBody2D":
		var y_delta = position.y - body.position.y
		var x_delta = body.position.x - position.x

		if y_delta > 30:
			print("Destroy enemy")
			queue_free()
			body.jump()
		else:
			print("Decrease player health")
			body.on_enemy_collision()
			
			if x_delta > 0:
				body.jump_side(500)
			else:
				body.jump_side(-500)
