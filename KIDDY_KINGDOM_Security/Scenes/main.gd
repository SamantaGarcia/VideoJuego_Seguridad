extends Node2D

onready var http : HTTPRequest = $HTTPRequest
onready var nameP : LineEdit = $LineEdit_1
onready var age : LineEdit = $LineEdit_2
onready var address : LineEdit = $LineEdit_3
onready var notificacion : Label = $notification
onready var content : Label = $content
onready var content2 : Label = $content2
onready var content3 : Label = $content3

var new_profile := false
var information_sent := false
var profile := {
	"nameP": {},
	"age": {},
	"address": {},
	"type": {}
}setget set_profile

func _ready() -> void:
	Firebase.get_document("users/%s" % Firebase.user_info.id, http)


func _on_HTTPRequest_request_completed(result: int, response_code: int, headers: PoolStringArray, body: PoolByteArray) -> void:
	var result_body := JSON.parse(body.get_string_from_ascii()).result as Dictionary
	match response_code:
		404:
			notificacion.text = "Please, enter your information"
			new_profile = true
			return
		200:
			if information_sent:
				notificacion.text = "Information saved successfully"
				information_sent = false
			self.profile = result_body.fields



func _on_Button_pressed():
	if nameP.text.empty() or age.text.empty() or address.text.empty():
		notificacion.text = "Complete all the fields"
	if int(age.text) < 7:
		notificacion.text = "You are too young to play this game"
		return
	profile.nameP = { "stringValue": nameP.text }
	profile.age = { "integerValue": age.text }
	profile.address = { "stringValue": address.text }
	if ( int(age.text) >= 7 && int(age.text) <= 9):
		profile.type = { "stringValue": "Baby User" }
	if ( int(age.text) >= 10 && int(age.text) <= 12):
		profile.type = { "stringValue": "Junior User" }
	if ( int(age.text) >= 13):
		profile.type = { "stringValue": "Senior User" }
	match new_profile:
		true:
			Firebase.save_document("users?documentId=%s" % Firebase.user_info.id, profile, http)
			
	information_sent = true
	
func set_profile(value: Dictionary) -> void:
	profile = value
	content.text = profile.nameP.stringValue
	content2.text = "Your content is for"
	content3.text = profile.type.stringValue
	


func _on_leave_pressed():
	get_tree().change_scene("res://Scenes/Welcome.tscn")
