extends Node2D

onready var http : HTTPRequest = $HTTPRequest
#onready var age : LineEdit = $LineEdit_Age
onready var email : LineEdit = $LineEdit_Email
onready var password : LineEdit = $LineEdit_Pass1
onready var confirm : LineEdit = $LineEdit_Pass2
onready var notification : Label = $Notification


func _on_HTTPRequest_request_completed(result: int, response_code: int, headers: PoolStringArray, body: PoolByteArray) -> void:
	var response_body := JSON.parse(body.get_string_from_ascii())
	if response_code != 200:
		notification.text = response_body.result.error.message.capitalize()
	else:
		notification.text = "Successfull Register"
		yield(get_tree().create_timer(2.0), "timeout")
		get_tree().change_scene("res://Scenes/Login.tscn")


func _on_register_pressed():
	if email.text.empty() or password.text.empty():
		notification.text = "Complete all the fields"
		return
	
	if password.text != confirm.text:
		notification.text = "Passwords do not match"
		return
		
	Firebase.register(email.text, password.text, http)


func _on_LinkButton_pressed():
	get_tree().change_scene("res://Scenes/Welcome.tscn")
