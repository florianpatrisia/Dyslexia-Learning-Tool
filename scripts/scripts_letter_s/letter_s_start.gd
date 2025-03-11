extends Control

@onready var play: Button = $HBoxContainer/Play
@onready var exit: Button = $HBoxContainer/Exit

func _on_play_pressed() -> void:
	if Globals.skip_intro == true:
		pass
	elif $Introduction.is_playing():
		return
	get_tree().change_scene_to_file("res://scenes/scenes_letter_s/snake_game/main_game.tscn") 


func _on_exit_pressed() -> void:
	if $Introduction.is_playing():
		return
	get_tree().change_scene_to_file("res://scenes/levels.tscn") 


func _on_play_mouse_entered() -> void:
	if $Introduction.is_playing():
		await $Introduction.finished
	else:
		$Exit.stop()
		play_sound($Play)


func _on_exit_mouse_entered() -> void:
	if $Introduction.is_playing():
		await $Introduction.finished
	else:
		$Play.stop()
		play_sound($Exit)


func _on_label_ready() -> void:
	if Globals.played_intro == false:
		print("Playing introduction!")
		play_sound($Introduction)
	if Globals.skip_intro == true:
		return


func play_sound(soundNode: AudioStreamPlayer) -> void:
	soundNode.play()
	# Change the snake to the tongue texture when the sound starts
	$Snake.texture = preload("res://assets/images/letter_s_scene/snake_open.png")


func _on_sound_finished() -> void:
	# Revert the snake to the normal texture when the sound finishes
	$Snake.texture = preload("res://assets/images/letter_s_scene/snake_closed.png")


func disable_button(button: Button) -> void:
	button.text = ""
	button.icon = ResourceLoader.load("res://assets/images/padlock.png")
	button.disabled = true
	button.icon_alignment = HORIZONTAL_ALIGNMENT_CENTER


func _on_play_ready() -> void:
	if Globals.skip_intro == true:
		return
	#if Globals.played_intro == false:
		#disable_button(play)


func _on_exit_ready() -> void:
	if Globals.skip_intro == true:
		return
	if Globals.played_intro == false:
		disable_button(exit)


func _on_introduction_finished() -> void:
	Globals.played_intro = true
	$Snake.texture = preload("res://assets/images/letter_s_scene/snake_closed.png")
	
