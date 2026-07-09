extends Control

signal disable_key_rebinding(diable_button:bool)#this is conected to the event buttons to diable them when 

var rebindable_actions:Dictionary = {
	#name of action in project settings : name you want to be displayed to the user, 
	#"crouch_action":"Crouch"
}


@onready var container:VBoxContainer = $ScrollContainer/VBoxContainer

const scene = preload("uid://br1xs5td3kolq")



func _ready() -> void:
	for action in rebindable_actions:
		var key_binding = scene.instantiate()
		key_binding.find_child("ActionName",true).text = rebindable_actions[action]
		container.add_child(key_binding)
		for event:InputEvent in InputMap.action_get_events(action):
			var button := EventButton.new()
			button.action = action
			button.input_event = event
			button.mother = self
			key_binding.find_child("HBoxButtonContainer",true).add_child(button)
