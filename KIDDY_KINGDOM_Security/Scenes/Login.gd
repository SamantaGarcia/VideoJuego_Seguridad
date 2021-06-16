extends Node2D

onready var http : HTTPRequest = $HTTPRequest
onready var email : LineEdit = $LineEdit_email
onready var password : LineEdit = $LineEdit_pass
onready var notification : Label = $notification

func _on_login_pressed():
	if email.text.empty() or password.text.empty():
		notification.text = "Complete all the fields"
		return
	Firebase.login(email.text, password.text, http)

func _on_HTTPRequest_request_completed(result, response_code, headers, body):
	var response_body := JSON.parse(body.get_string_from_ascii())
	if response_code != 200:
		notification.text = response_body.result.error.message.capitalize()
	else:
		notification.text = "Successfull login"
		yield(get_tree().create_timer(2.0), "timeout")
		get_tree().change_scene("res://Scenes/main.tscn")


func _on_LinkButton_pressed():
	get_tree().change_scene("res://Scenes/Register.tscn")


func _on_return_pressed():
	get_tree().change_scene("res://Scenes/Welcome.tscn")
