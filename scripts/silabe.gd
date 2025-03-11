extends Control


func _ready() -> void:
	var silabe = $Silabe.get_children()
	for silaba in silabe:
		var litere_silaba = silaba.name.split('_',false,1)
		litere_silaba.remove_at(0)
		for litera in litere_silaba[0]:
			if 'Litera_' + litera in Globals.litere_necompletate:
				silaba.disabled = false
				break


func _on_back_pressed() -> void:
	get_tree().change_scene_to_file("res://scenes/levels.tscn")


func _on_silaba_ie_pressed() -> void:
	get_tree().change_scene_to_file("res://scenes/silaba_ie.tscn")


func _on_silaba_ca_pressed() -> void:
	get_tree().change_scene_to_file("res://scenes/scenes_silaba_ca/silaba_ca.tscn")


func _on_silaba_ma_pressed() -> void:

	# Obținem dimensiunile ferestrei actuale
	var screen_size = DisplayServer.window_get_size()
	var screen_width = screen_size.x  # Lățimea ecranului
	var screen_height = screen_size.y  # Înălțimea ecranului
	
	var new_size = Vector2(540, 960)  # Dimensiune dorită

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

	# Schimbăm scena
	get_tree().change_scene_to_file("res://joc-ma/scenes/game.tscn")
