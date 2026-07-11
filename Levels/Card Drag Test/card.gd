extends Control
class_name TestCard

func _get_drag_data(_at_position: Vector2) -> Variant:
	set_drag_preview(self.duplicate())
	return self


func _notification(what: int) -> void:
	if what == NOTIFICATION_DRAG_END and is_drag_successful():
		#do card cooldown
		print("card goes on cooldown")
		pass
