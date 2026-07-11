class_name Card extends Control

func card_function():
	pass

func _on_button_pressed() -> void:
	card_function()
	self.queue_free()
