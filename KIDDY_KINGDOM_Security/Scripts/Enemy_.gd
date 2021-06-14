extends KinematicBody2D

var Player1 = null
var move = Vector2.ZERO
var speed = 900

func _physics_process(delta):
	move = Vector2.ZERO
	
	if Player1 != null:
		move = position.direction_to(Player1.position) * speed * 1000
	else:
		move = Vector2.ZERO
	
	move = move.normalized()
	move = move_and_collide(move)


func _on_Area2D_body_entered(body):
	if (body.get_name() == "Player1"):
		Player1 = body
		


func _on_Area2D_body_exited(body):
	Player1 = null
