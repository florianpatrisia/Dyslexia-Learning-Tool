extends Control

func _on_restart_button_pressed():
	get_tree().reload_current_scene()

func set_score(value):
	$Panel/Score.text = "Score: " + str(value)

func set_high_score(value):
	$Panel/HighScore.text = "Hi-Score: " + str(value)


func _on_close_pressed() -> void:
	#var screen_size = DisplayServer.window_get_size()
	#var screen_width = screen_size.x  # Lățimea ecranului
	#var screen_height = screen_size.y  # Înălțimea ecranului
	
	var new_size = Vector2(1152, 648)  # Dimensiune dorită

	# Dacă înălțimea ferestrei este mai mare decât înălțimea ecranului, redimensionăm
	#if new_size.y > screen_height:
		#new_size.y = screen_height  # Redimensionăm la înălțimea ecranului
		#new_size.x = (new_size.y * 540) / 960  # Ajustăm lățimea pentru a păstra raportul de aspect

	# Calculăm poziția centrală
	#var new_x = (screen_width - new_size.x) / 2
	#var new_y = (screen_height - new_size.y) / 2

	# Setăm dimensiunea și poziția ferestrei
	DisplayServer.window_set_size(new_size)
	#DisplayServer.window_set_position(Vector2(new_x, new_y))
	DisplayServer.window_set_mode(DisplayServer.WindowMode.WINDOW_MODE_WINDOWED)
	get_tree().change_scene_to_file("res://scenes/silabe.tscn")
	# Replace with function body.
