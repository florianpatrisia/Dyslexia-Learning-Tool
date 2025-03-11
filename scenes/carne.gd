extends PanelContainer

func _get_drag_data(at_position: Vector2) -> Variant:
	
	var preview = self.duplicate() 
	set_drag_preview(preview)
	var label = $BoxContainer/Carne
	var data = [self,label.text]
	return data
