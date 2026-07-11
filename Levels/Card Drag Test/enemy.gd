extends Control

func _can_drop_data(at_position: Vector2, data: Variant) -> bool:
	if data is TestCard:
		return true
	else:
		return false



func _drop_data(at_position: Vector2, data: Variant) -> void:
	print(data)
