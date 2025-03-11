extends Control


func _on_exit_pressed() -> void:
	if $Introduction.is_playing():
		return
	get_tree().change_scene_to_file("res://scenes/scenes_letter_s/letter_s_start.tscn")


func _on_exit_mouse_entered() -> void:
	if $Introduction.is_playing():
		await $Introduction.finished
	else:
		play_sound($Exit)


func _on_label_ready() -> void:
	if Globals.played_intro == false:
		play_sound($Introduction)
	if Globals.skip_intro == true:
		return


func play_sound(soundNode: AudioStreamPlayer) -> void:
	soundNode.play()
	$Snake.texture = preload("res://assets/images/letter_s_scene/snake_open.png")


func _on_sound_finished() -> void:
	$Snake.texture = preload("res://assets/images/letter_s_scene/snake_closed.png")


func _on_introduction_finished() -> void:
	Globals.played_intro = true
	$Snake.texture = preload("res://assets/images/letter_s_scene/snake_closed.png")
	
