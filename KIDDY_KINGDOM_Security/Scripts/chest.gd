extends Area2D


func _ready():
	$CanvasLayer/Node2D.hide()

func _on_Button_pressed():
	$CanvasLayer/Node2D.hide()
	remove_and_skip()

func _on_Chest_body_entered(body):
	if (body.get_name() == "Player1"):
		$CanvasLayer/Node2D.show()
		print(body.get_name())
		
#		$AudioStreamPlayer2D.volume_db = 10
#		if ($AudioStreamPlayer2D.playing == false):
#				$AudioStreamPlayer2D.play()
