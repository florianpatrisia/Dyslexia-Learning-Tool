extends Control


func _on_play_pressed() -> void:
	if Globals.skip_intro == true:
		pass
	elif $Titlu.is_playing():
		return;
	get_tree().change_scene_to_file("res://scenes/levels.tscn") 


func _on_exit_pressed() -> void:
	if $Titlu.is_playing():
		return;
	get_tree().quit() 


func _on_play_mouse_entered() -> void:
	if $Titlu.is_playing():
		await $Titlu.finished
	else:
		$Iesi.stop()
		play_sound($Joaca) # Replace with function body.


func _on_exit_mouse_entered() -> void:
	if $Titlu.is_playing():
		await $Titlu.finished
	else:
		$Joaca.stop()
		play_sound($Iesi) # Replace with function body.


func _on_label_ready() -> void:
	if Globals.skip_intro == true:
		return;
	if Globals.played_intro == false:
		play_sound($Titlu)

func play_sound(soundNode: AudioStreamPlayer) -> void:
	soundNode.play()
	
func disable_button(button: Button) -> void:
	button.text = ""
	button.icon = ResourceLoader.load("res://assets/images/padlock.png")
	button.disabled = true
	button.icon_alignment = HORIZONTAL_ALIGNMENT_CENTER


func _on_play_ready() -> void:
	if Globals.skip_intro == true:
		return; 
	if Globals.played_intro == false:
		disable_button($VBoxContainer/Play)


func _on_exit_ready() -> void:
	if Globals.skip_intro == true:
		return;
	if Globals.played_intro == false:
		disable_button($VBoxContainer/Exit)


func _on_titlu_finished() -> void:
	$VBoxContainer/Play.text = "Intră în aventură"
	$VBoxContainer/Exit.text = "Închide jocul"
	$VBoxContainer/Play.disabled = false 
	$VBoxContainer/Exit.disabled = false 
	$VBoxContainer/Exit.icon = null 
	$VBoxContainer/Play.icon = null
	Globals.played_intro = true
