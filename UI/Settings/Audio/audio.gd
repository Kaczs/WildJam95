extends Control

@onready var audio_container:VBoxContainer = %VBoxAudioContainer

var display_audio_dus:Array = [
	"Master",
	"SFX",
	"Music",
	
]

#in the future I should just make a secne
#but it was fun
func _ready() -> void:
	for bus_name in display_audio_dus:
		var bus_index = AudioServer.get_bus_index(bus_name)
		print(AudioServer.get_bus_volume_linear(bus_index))
		
		var box = HBoxContainer.new()
		audio_container.add_child(box)
		
		var slider:HSlider = HSlider.new()
		slider.max_value = 1
		slider.step = 0.01
		slider.value = AudioServer.get_bus_volume_linear(bus_index)
		slider.custom_minimum_size = Vector2(400,20)
		
		slider.value_changed.connect(
		func(value): 
			AudioServer.set_bus_volume_linear(bus_index, value)
		)
		
		slider.value_changed.connect(
		func(_value): 
			print(AudioServer.get_bus_volume_db(bus_index))
		)
		
		box.add_child(slider)
		
		var button:Button = Button.new()
		button.text = str("Mute ", bus_name)
		
		button.pressed.connect(
		func(): 
			if AudioServer.is_bus_mute(bus_index):
				#mutes bus
				button.text = str("Mute ", bus_name)
				AudioServer.set_bus_mute(bus_index,false)
				slider.set_editable(true)
			else:
				#unmutes bus
				button.text = str("Unmute ", bus_name)
				AudioServer.set_bus_mute(bus_index,true)
				slider.set_editable(false)
		)
		
		box.add_child(button)
	
