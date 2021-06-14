extends Node2D




func _on_Area2D_body_entered(body):
	if (body.get_name() == "Player1"):
		Resources.Keys += 1
		get_node("main").get_node("GUI/Label_key").text = str(Resources.Keys)
		
		$Area2D.hide()
		remove_and_skip()
		
		

