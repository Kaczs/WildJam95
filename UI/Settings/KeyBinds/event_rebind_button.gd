extends Button
class_name EventButton

var action:String #the action group that this button is bound too
var input_event:InputEvent #the input event that this button is currently bound too
var mother #the node that made this button, should be the key_binds node in settings
var rebinding := false


func _ready() -> void:
	#when you take an event that is set in the godot editor it adds " - Physical" 
	#so we remove it before setting the text of the button
	self.text = input_event.as_text().trim_suffix(" - Physical")
	mother.disable_key_rebinding.connect(_on_disable_key_rebinding)
	self.pressed.connect(_on_pressed)


func _on_pressed() -> void:
	mother.disable_key_rebinding.emit(true)
	rebinding = true
	self.text = "new key please"


#stops the player from rebinding multiple actions at once by diabling all buttons that are used to rebind actions
func _on_disable_key_rebinding(diable_button:bool) -> void:
	self.set_disabled(diable_button)
	if rebinding:
		rebinding = false
		self.text = input_event.input_event.as_text().trim_suffix(" - Physical")


#I use unhandle inputs to stop the mouse from showing up
#I dont think this is the best way to rebind a event to an action but I dont see any problems so far
func _unhandled_input(event: InputEvent) -> void:
	if rebinding:
		#we clear the event here so that we can cancel the redinding if needed ie. if the the player closes th UI
		InputMap.action_erase_event(action,input_event)
		InputMap.action_add_event(action,event)
		rebinding = false
		#must disable rebinging first or _on_disable_key_rebinding will run
		mother.disable_key_rebinding.emit(false)
		self.text = event.as_text()
		input_event = event
